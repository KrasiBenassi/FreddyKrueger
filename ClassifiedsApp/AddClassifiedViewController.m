//
//  AddClassifiedViewController.m
//  ClassifiedsApp
//
//  Created by Admin on 10/31/14.
//  Copyright (c) 2014 Telerik Academy. All rights reserved.
//

#import "AddClassifiedViewController.h"
#import "TableViewController.h"
#import <CoreLocation/CoreLocation.h>
#import <Parse/Parse.h>

#import "CDHelper.h"
#import "MyClassifieds.h"

@interface AddClassifiedViewController ()<CLLocationManagerDelegate>
@property (nonatomic, strong) CDHelper *cdHelper;
@end

@implementation AddClassifiedViewController{
    CLLocationManager *locationManager;
}

NSString *const ClassName = @"Classifieds";
NSString *const LogoText = @"Add Classified";
NSString *const MyClassName = @"MyClassifieds";
NSString *const Title = @"Title";
NSString *const Description = @"Description";
NSString *const Price = @"Price";
NSString *const Name = @"Name";
NSString *const City = @"City";
NSString *const Address = @"Address";
NSString *const Phone = @"Phone";
NSString *const Picture = @"Picture";
NSString *const DateFormat = @"dd-MM-yyyy-HH-mm-ss";
NSString *const BackgroundPicture = @"Striped_Tranquil.jpg";
NSString *const ErrTitleForm = @"Invalid form";
NSString *const ErrTitleTitle = @"Invalid Title";
NSString *const ErrTitleDescription = @"Invalid Description";
NSString *const ErrTitlePhone = @"Invalid Phone number";
NSString *const ErrTitleAddress = @"Invalid Address name";
NSString *const ErrTitleName = @"Invalid Name";
NSString *const ErrTitlePrice = @"Invalid Price";
NSString *const ErrMessageForm = @"All fields must not be empty";
NSString *const ErrMessageTitle = @"Title must be between 5 and 50 letters long";
NSString *const ErrMessageDescription = @"Description must be between 10 and 200 letters long";
NSString *const ErrMessagePhone = @"Invalid phone number. \n Use only digits (no whitespace).\n Phone must be between 5 and 20 digits long";
NSString *const ErrMessageAddress = @"Address must be between 2 and 20 letters long";
NSString *const ErrMessageName = @"Name must be between 2 and 20 letters long";
NSString *const ErrMessagePrice = @"Use only digits (no whitespace).\n If it\'s negotiable enter 0.\n Authorized price to 7 digits.";
NSString *const BtnCanselMessage = @"Close";
NSString *const ErrorCameraTitle = @"Error Camera";
NSString *const ErrorCameraMessage = @"Device has no camera!";
NSString *const ErrorLocationTitle = @"Location error";

@synthesize scroller;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = LogoText;
    
    locationManager = [[CLLocationManager alloc] init];
    locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters;
    locationManager.delegate = self;
    locationManager.distanceFilter = kCLLocationAccuracyHundredMeters;
    
    [locationManager requestAlwaysAuthorization];
    [locationManager startUpdatingLocation];
    
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        
        UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:ErrorCameraTitle
                                                              message:ErrorCameraMessage
                                                             delegate:nil
                                                    cancelButtonTitle:BtnCanselMessage
                                                    otherButtonTitles: nil, nil];
        
        [myAlertView show];
    }
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:BackgroundPicture]];
    
    [scroller setScrollEnabled:YES];
    [scroller setContentSize:CGSizeMake(320, 1049)];
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
    CLLocation *location = [locations lastObject];
    CLGeocoder *coder = [[CLGeocoder alloc] init];
    
    [coder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error) {
        CLPlacemark *mark = [placemarks lastObject];
        // NSLog(@"%@", mark.addressDictionary);
        _txtAddress.text = mark.addressDictionary[City];
    }];
    
    [locationManager pausesLocationUpdatesAutomatically];
}

-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    [[[UIAlertView alloc] initWithTitle:ErrorLocationTitle
                                message:[NSString stringWithFormat:@"Error: %@", error]
                               delegate:nil
                      cancelButtonTitle:BtnCanselMessage
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
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        
        UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:ErrorCameraTitle
                                                              message:ErrorCameraMessage
                                                             delegate:nil
                                                    cancelButtonTitle:BtnCanselMessage
                                                    otherButtonTitles: nil, nil];
        
        [myAlertView show];
    } else {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.allowsEditing = YES;
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        
        [self presentViewController:picker animated:YES completion:NULL];
    }
    
}

- (IBAction)selectPhoto:(UIButton *)sender {
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    [self presentViewController:picker animated:YES completion:NULL];
    
}

- (PFFile *)convertPicture:(NSString*) imageName{
    NSData *imageData = UIImageJPEGRepresentation(_imageView.image, 0.1);
    PFFile *imageFile = [PFFile fileWithName:imageName data:imageData];
    
    return imageFile;
}

- (NSString*)getNameForImage{
    NSDateFormatter *formatter;
    NSString        *dateString;
    NSMutableString *imageName;
    
    formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:DateFormat];
    
    dateString = [formatter stringFromDate:[NSDate date]];
    imageName = [NSMutableString stringWithString:dateString];
    [imageName appendString:@".jpg"];
    
    return imageName;
}

- (IBAction)saveClassified:(UIButton *)sender {
    BOOL isValid = [self isValidForm];
    
    if(isValid){
        NSString *title = _txtTitle.text;
        NSString *description = _txtDescription.text;
        NSString *address = _txtAddress.text;
        NSString *phone = _txtPhone.text;
        NSString *name = _txtName.text;
        NSString *price = _txtPrice.text;
        NSString *pictureName = [self getNameForImage];
        
        //Uploading into Parse.com
        PFObject *classified = [PFObject objectWithClassName:ClassName];
        classified[Title] = title;
        classified[Description] = description;
        classified[Address] = address;
        classified[Phone] = phone;
        classified[Name] = name;
        classified[Price] = [NSString stringWithFormat:@"$%@", price];
        classified[Picture] = [self convertPicture:pictureName];
        
        [classified save];
        
        _cdHelper = [CDHelper instance];
        [_cdHelper setupCoreData];
        MyClassifieds* myClassifieds = [NSEntityDescription insertNewObjectForEntityForName:MyClassName inManagedObjectContext:_cdHelper.context];
        
        //Uploading into Core Data
        NSData *imageData = UIImageJPEGRepresentation(_imageView.image, 0.1);
        
        myClassifieds.picture = imageData;
        myClassifieds.title = title;
        myClassifieds.descriptionText = description;
        myClassifieds.address = address;
        myClassifieds.name = name;
        myClassifieds.priceValue = [NSString stringWithFormat:@"$%@", price];
        myClassifieds.phone = phone;
        myClassifieds.classifiedId = [classified objectId];
        
        [_cdHelper.context insertObject:myClassifieds];
        
        [self.cdHelper saveContext];
        
        TableViewController *wc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]
                                   instantiateViewControllerWithIdentifier:@"TableViewController"];
        [self.navigationController pushViewController:wc animated:YES];
    }
}

-(BOOL) isValidForm{
    NSString *titleText = _txtTitle.text;
    NSString *descriptionText = _txtDescription.text;
    NSString *phoneText = _txtPhone.text;
    NSString *nameText = _txtName.text;
    NSString *priceText = _txtPrice.text;
    NSString *cityText = _txtAddress.text;
    
    BOOL validPhone;
    BOOL validPrice;
    NSCharacterSet *alphaNums = [NSCharacterSet decimalDigitCharacterSet];
    NSCharacterSet *phoneTextSet = [NSCharacterSet characterSetWithCharactersInString:phoneText];
    NSCharacterSet *priceTextSet = [NSCharacterSet characterSetWithCharactersInString:priceText];
    validPhone = [alphaNums isSupersetOfSet:phoneTextSet];
    validPrice = [alphaNums isSupersetOfSet:priceTextSet];
    
    if(titleText.length == 0 || descriptionText.length == 0|| phoneText.length == 0 || nameText.length == 0 || priceText.length == 0 || cityText.length == 0){
        [self initTitle:ErrTitleForm
           throwMessage:ErrMessageForm
            useDelegate:nil
              btnCancel:BtnCanselMessage
               btnOther:nil];
        return NO;
    } else if(titleText.length < 5 || titleText.length > 50){
        [self initTitle:ErrTitleTitle
           throwMessage:ErrMessageTitle
            useDelegate:nil
              btnCancel:BtnCanselMessage
               btnOther:nil];
        return NO;
    } else if (descriptionText.length < 10 || descriptionText.length > 200){
        [self initTitle:ErrTitleDescription
           throwMessage:ErrMessageDescription
            useDelegate:nil
              btnCancel:BtnCanselMessage
               btnOther:nil];
        return NO;
    } else if(cityText.length <2 || cityText.length >20){
        [self initTitle:ErrTitleAddress
           throwMessage:ErrMessageAddress
            useDelegate:nil
              btnCancel:BtnCanselMessage
               btnOther:nil];
        return NO;
    } else if(!validPhone || phoneText.length < 5 || phoneText.length > 20){
        [self initTitle:ErrTitlePhone
           throwMessage:ErrMessagePhone
            useDelegate:nil
              btnCancel:BtnCanselMessage
               btnOther:nil];
        return NO;
    } else if (nameText.length < 2 || nameText.length > 20){
        [self initTitle:ErrTitleName
           throwMessage:ErrMessageName
            useDelegate:nil
              btnCancel:BtnCanselMessage
               btnOther:nil];
        return NO;
    } else if (!validPrice || priceText.length > 7){
        [self initTitle:ErrTitlePrice
           throwMessage:ErrMessagePrice
            useDelegate:nil
              btnCancel:BtnCanselMessage
               btnOther:nil];
        return NO;
    }
    
    return YES;
}

-(void) initTitle:(NSString*)title
     throwMessage:(NSString*)message
      useDelegate:(id)delegateName
        btnCancel:(NSString*)btnCancelTitle
         btnOther:(NSString*)btnOtherTitle{
    
    UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:title
                                                          message:message
                                                         delegate:delegateName
                                                cancelButtonTitle:btnCancelTitle
                                                otherButtonTitles: btnOtherTitle, nil];
    [myAlertView show];
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
