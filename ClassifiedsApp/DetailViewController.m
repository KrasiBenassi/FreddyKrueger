//
//  DetailViewController.m
//  ClassifiedsApp
//
//  Created by Admin on 10/30/14.
//  Copyright (c) 2014 Telerik Academy. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()

@end

@implementation DetailViewController

NSString *const DVTitle = @"Title";
NSString *const DVDescription = @"Description";
NSString *const DVPrice = @"Price";
NSString *const DVName = @"Name";
NSString *const DVCity = @"City";
NSString *const DVAddress = @"Address";
NSString *const DVPhone = @"Phone";
NSString *const DVPicture = @"Picture";
NSString *const DVBackgroundPicture = @"Striped_Tranquil.jpg";

- (void)viewDidLoad {
    [super viewDidLoad];
     //Do any additional setup after loading the view..
    _lblTitle.text = _detailModal[0][DVTitle];
    _lblDescription.text = _detailModal[0][DVDescription];
    _imageView.image = [UIImage imageWithData:_detailModal[0][DVPicture]];
    _lblPrice.text = _detailModal[0][DVPrice];
    _lblPhone.text = _detailModal[0][DVPhone];
    _lblName.text = _detailModal[0][DVName];
    _lblLocation.text = _detailModal[0][DVAddress];
    [_lblPrice sizeToFit];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:DVBackgroundPicture]];
    self.navigationItem.title = _detailModal[0][DVTitle];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)myPinch:(UIGestureRecognizer *)sender {
    CGFloat lastScaleFactor = 1;
    CGFloat factor = [(UIPinchGestureRecognizer*) sender scale];
    
    if(factor >1){ //zooming in
        _imageView.transform = CGAffineTransformMakeScale(
                                                          lastScaleFactor + (factor - 1),
                                                          lastScaleFactor + (factor - 1)
                                                          );
    } else {
        _imageView.transform = CGAffineTransformMakeScale(
                                                          lastScaleFactor * factor,
                                                          lastScaleFactor * factor
                                                          );
    }
    
    if(sender.state == UIGestureRecognizerStateEnded){
        if(factor > 1){
            lastScaleFactor += (factor -1);
        } else {
            lastScaleFactor *= factor;
        }
    }
}

- (IBAction)myTap:(UITapGestureRecognizer *)sender {
    if (sender.view.contentMode == UIViewContentModeScaleAspectFit) {
        sender.view.contentMode = UIViewContentModeCenter;
    }else{
        sender.view.contentMode = UIViewContentModeScaleAspectFit;
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
