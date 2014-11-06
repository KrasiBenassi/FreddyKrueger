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

- (void)viewDidLoad {
    [super viewDidLoad];
     //Do any additional setup after loading the view..
    _lblTitle.text = _detailModal[0][@"Title"];
    _lblDescription.text = _detailModal[0][@"Description"];
    _imageView.image = [UIImage imageWithData:_detailModal[0][@"Picture"]];
    _lblPrice.text = _detailModal[0][@"Price"];
    _lblPhone.text = _detailModal[0][@"Phone"];
    _lblName.text = _detailModal[0][@"Name"];
    _lblLocation.text = _detailModal[0][@"Address"];
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Striped_Tranquil.jpg"]];
    self.navigationItem.title = _detailModal[0][@"Title"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
