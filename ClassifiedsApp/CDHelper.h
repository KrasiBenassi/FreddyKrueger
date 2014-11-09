//
//  CDHelper.h
//  ClassifiedsApp
//
//  Created by Admin on 11/8/14.
//  Copyright (c) 2014 Telerik Academy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CoreData/CoreData.h"

@interface CDHelper : NSObject

@property (nonatomic, strong) NSManagedObjectContext* context;
@property (nonatomic, strong) NSManagedObjectModel* model;
@property (nonatomic, strong) NSPersistentStoreCoordinator* coordinator;
@property (nonatomic, strong) NSPersistentStore* store;

+(id)instance;
-(void)saveContext;
-(void)setupCoreData;
@end
