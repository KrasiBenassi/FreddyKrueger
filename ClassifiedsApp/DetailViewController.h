//
//  DetailViewController.h
//  ClassifiedsApp
//
//  Created by Admin on 10/30/14.
//  Copyright (c) 2014 Telerik Academy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property (strong, nonatomic)IBOutlet UILabel *lblTitle;
@property (strong, nonatomic)IBOutlet UILabel *lblDescription;
@property (strong, nonatomic)IBOutlet UIImageView *imageView;
@property (strong, nonatomic) IBOutlet UILabel *lblPrice;
@property (strong, nonatomic) IBOutlet UILabel *lblPhone;
@property (strong, nonatomic) IBOutlet UILabel *lblName;
@property (strong, nonatomic) IBOutlet UILabel *lblLocation;


@property (strong, nonatomic)NSArray *detailModal;

@end
