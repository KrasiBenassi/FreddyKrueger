//
//  TALocationProvider.m
//  ClassifiedsApp
//
//  Created by Admin on 11/3/14.
//  Copyright (c) 2014 Telerik Academy. All rights reserved.
//

#import "TALocationProvider.h"
#import <CoreLocation/CoreLocation.h>

@implementation TALocationProvider{
    CLLocationManager* locationManager;
    void (^_block)(CLLocation *);
}

-(instancetype)init{
    if(self = [self init]){
        locationManager = [[CLLocationManager alloc] init];
        [self setupLocationManager];
    }
    
    return self;
}

-(void)setupLocationManager{
    locationManager.desiredAccuracy = kCLLocationAccuracyKilometer;
    locationManager.delegate = self;
}

@end
