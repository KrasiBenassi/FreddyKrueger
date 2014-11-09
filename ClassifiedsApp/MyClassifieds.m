//
//  MyClassifieds.m
//  ClassifiedsApp
//
//  Created by Admin on 11/8/14.
//  Copyright (c) 2014 Telerik Academy. All rights reserved.
//

#import "MyClassifieds.h"


@implementation MyClassifieds

-(instancetype) initWithName: (NSString *) mcName
                     clPrice: (NSString *) mcPrice
                   clAddress: (NSString *) mcAddress
                     clTitle: (NSString *) mcTitle
               clDescription: (NSString *) mcDescription
                   clPicture: (NSData *) mcPicture
               clPicturename: (NSString *) mcPictureName
                     clPhone:(NSString *)mcPhone
{
    self = [super init];
    if(self){
        self.name = mcName;
        self.price = mcPrice;
        self.address = mcAddress;
        self.title = mcTitle;
        self.descriptionText = mcDescription;
        self.picture = mcPicture;
        self.pictureName = mcPictureName;
        self.phone = mcPhone;
    }
    
    return self;
}

@dynamic name;
@dynamic price;
@dynamic address;
@dynamic title;
@dynamic descriptionText;
@dynamic picture;
@dynamic pictureName;
@dynamic phone;

@end
