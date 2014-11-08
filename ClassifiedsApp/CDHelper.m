//
//  CDHelper.m
//  ClassifiedsApp
//
//  Created by Admin on 11/8/14.
//  Copyright (c) 2014 Telerik Academy. All rights reserved.
//

#import "CDHelper.h"

@implementation CDHelper

NSString *storeFilename = @"CDatabase.sqlite";

-(id)init{
    NSLog(@"Running %@ '%@'", self.class, NSStringFromSelector(_cmd));
    
    self = [super init];
    if(!self){
        return nil;
    }
    
    _model = [NSManagedObjectModel mergedModelFromBundles:nil];
    _coordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:_model];
    _context = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    [_context setPersistentStoreCoordinator: _coordinator];
    
    return self;
}

-(NSURL*) storeURL{
    NSLog(@"Running %@ '%@'", self.class, NSStringFromSelector(_cmd));
    
    return [[self applicationStoresDirectory] URLByAppendingPathComponent:storeFilename];
}

-(void)loadStore{
    NSLog(@"Running %@ '%@'", self.class, NSStringFromSelector(_cmd));

    if(_store){
        return;
    }
    
    NSError *error = nil;
    _store = [_coordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:[self storeURL] options:nil error:&error];
    
    if(!_store){
        NSLog(@"Failed to add stores. Error: %@", error);
        abort();
    } else {
        NSLog(@"Successfully added store: %@", _store);
    }
}

-(void)setupCoreData{
    NSLog(@"Running %@ '%@'", self.class, NSStringFromSelector(_cmd));

    [self loadStore];
}

-(void) saveContext{
    NSLog(@"Running %@ '%@'", self.class, NSStringFromSelector(_cmd));

    if([_context hasChanges]){
        NSError *error = nil;
        if([_context save: &error]){
            NSLog(@"_context SAVED changes to persistent store");
        } else {
            NSLog(@"Failed to save _context: %@", error);
        }
    } else {
        NSLog(@"Skipped _context save, there are no changes!");
    }
}

-(NSString*)applicationDocumentsDirectory{
    NSLog(@"Running %@ '%@'", self.class, NSStringFromSelector(_cmd));
    
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
}

-(NSURL*)applicationStoresDirectory
{
    NSLog(@"Running %@ '%@'", self.class, NSStringFromSelector(_cmd));
    
    NSURL *storesDirectory = [[NSURL fileURLWithPath:[self applicationDocumentsDirectory]]
                              URLByAppendingPathComponent:@"Stores"];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    if(![fileManager fileExistsAtPath:[storesDirectory path]]){
        NSError *error = nil;
        if([fileManager createDirectoryAtURL:storesDirectory withIntermediateDirectories:YES attributes:nil error:&error]){
            if(DEBUG==1){
                NSLog(@"Successfully created Stores directory");
            }
        } else {
            NSLog(@"Failed to create Stores directory: %@", error);
        }
    }
    return storesDirectory;
}


@end
