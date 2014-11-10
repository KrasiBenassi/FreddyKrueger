//
//  MyClassifieds.h
//  ClassifiedsApp
//
//  Created by Admin on 11/8/14.
//  Copyright (c) 2014 Telerik Academy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface MyClassifieds : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * price;
@property (nonatomic, retain) NSString * address;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSString * descriptionText;
@property (nonatomic, retain) NSData * picture;
@property (nonatomic, retain) NSString * pictureName;
@property (nonatomic, retain) NSString * phone;
@property (nonatomic, retain) NSString * classifiedId;

-(instancetype) initWithName: (NSString *) mcName
                     clPrice: (NSString *) mcPrice
                   clAddress: (NSString *) mcAddress
                     clTitle: (NSString *) mcTitle
               clDescription: (NSString *) mcDescription
                   clPicture: (NSData *) mcPicture
               clPicturename: (NSString *) mcPictureName
                     clPhone: (NSString *) mcPhone
                        clId: (NSString *) mcId;

@end
