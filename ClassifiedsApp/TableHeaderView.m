//
//  TableHeaderView.m
//  ClassifiedsApp
//
//  Created by Admin on 10/31/14.
//  Copyright (c) 2014 Telerik Academy. All rights reserved.
//

#import "TableHeaderView.h"

@interface TableHeaderView()
{
    UILabel *label;
}
@end

@implementation TableHeaderView

-(id)initWithText:(NSString*)text {
    
    UIImage *img = [UIImage imageNamed:@"city6.png"];
    if ((self = [super initWithImage:img])) {
        label = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 200, 50)];
        label.textColor = [UIColor grayColor];
        label.backgroundColor = [UIColor clearColor];
        label.font = [UIFont systemFontOfSize:20];
        label.text = text;
        label.numberOfLines = 1;
        [self addSubview:label];
    }
    
    return self;
}

-(void)setText:(NSString*)text {
    label.text = text;
}

@end
