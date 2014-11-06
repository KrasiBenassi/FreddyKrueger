//
//  AddClassifiedViewController.m
//  ClassifiedsApp
//
//  Created by Admin on 10/31/14.
//  Copyright (c) 2014 Telerik Academy. All rights reserved.
//

#import "AddClassifiedViewController.h"
#import <CoreLocation/CoreLocation.h>
#import <Parse/Parse.h>

@interface AddClassifiedViewController ()<CLLocationManagerDelegate>

@end

@implementation AddClassifiedViewController{
    CLLocationManager *locationManager;
}

@synthesize scroller;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    locationManager = [[CLLocationManager alloc] init];
    locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters;
    locationManager.delegate = self;
    locationManager.distanceFilter = kCLLocationAccuracyHundredMeters;
    
    [locationManager requestAlwaysAuthorization];
    [locationManager startUpdatingLocation];
    
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        
        UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:@"Error"
                                                              message:@"Device has no camera"
                                                             delegate:nil
                                                    cancelButtonTitle:@"OK"
                                                    otherButtonTitles: nil, nil];
        
        [myAlertView show];
    }
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Striped_Tranquil.jpg"]];
    
    [scroller setScrollEnabled:YES];
    [scroller setContentSize:CGSizeMake(320, 1049)];
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
    CLLocation *location = [locations lastObject];
    CLGeocoder *coder = [[CLGeocoder alloc] init];
    
    [coder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error) {
        CLPlacemark *mark = [placemarks lastObject];
        // NSLog(@"%@", mark.addressDictionary);
        _txtAddress.text = mark.addressDictionary[@"City"];
    }];
    
    [locationManager pausesLocationUpdatesAutomatically];
}

-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    [[[UIAlertView alloc] initWithTitle:@"Location error"
                                message:[NSString stringWithFormat:@"Error: %@", error]
                               delegate:nil
                      cancelButtonTitle:@"OK"
                      otherButtonTitles:nil, nil]
     show];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)takePhoto:(UIButton *)sender {
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    
    [self presentViewController:picker animated:YES completion:NULL];
    
}

- (IBAction)selectPhoto:(UIButton *)sender {
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    [self presentViewController:picker animated:YES completion:NULL];
    
}

- (PFFile *)base64String {
    NSDateFormatter *formatter;
    NSString        *dateString;
    NSMutableString *imageName;
    
    formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"dd-MM-yyyy-HH-mm-ss"];
    
    dateString = [formatter stringFromDate:[NSDate date]];
    imageName = [NSMutableString stringWithString:dateString];
    [imageName appendString:@".jpg"];
    
    NSData *imageData = UIImageJPEGRepresentation(_imageView.image, 0.1);
    PFFile *imageFile = [PFFile fileWithName:imageName data:imageData];
    
    return imageFile;
}

- (IBAction)saveClassified:(UIButton *)sender {
    NSString *title = _txtTitle.text;
    NSString *description = _txtDescription.text;
    NSString *address = _txtAddress.text;
    NSString *phone = _txtPhone.text;
    NSString *name = _txtName.text;
    NSString *price = _txtPrice.text;
    
    PFObject *classified = [PFObject objectWithClassName:@"Classifieds"];
    classified[@"Title"] = title;
    classified[@"Description"] = description;
    classified[@"Address"] = address;
    classified[@"Phone"] = phone;
    classified[@"Name"] = name;
    classified[@"Price"] = price;
    //[classified setObject:_imageView.image forKey:@"Image"];
    classified[@"Picture"] = self.base64String;
    [classified saveInBackground];
}

#pragma mark - Image Picker Controller delegate methods

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    self.imageView.image = chosenImage;
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}
@end
