//
//  MyClassifiedsController.h
//  ClassifiedsApp
//
//  Created by Admin on 11/8/14.
//  Copyright (c) 2014 Telerik Academy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyClassifiedsController : UITableViewController
@property (nonatomic, strong)NSMutableArray *Images;
@property (nonatomic, strong)NSMutableArray *Titles;
@property (nonatomic, strong)NSMutableArray *Descriptions;
@property (nonatomic, strong)NSMutableArray *Prices;

@property (nonatomic, strong)NSArray *ClassifiedsArr;
@property (nonatomic, strong)NSMutableArray *ClassifiedsInfo;
@end
