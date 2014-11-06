//
//  TALocationProvider.m
//  ClassifiedsApp
//
//  Created by Admin on 11/3/14.
//  Copyright (c) 2014 Telerik Academy. All rights reserved.
//

#import "TALocationProvider.h"
#import <CoreLocation/CoreLocation.h>

@interface TALocationProvider()<CLLocationManagerDelegate>

@end

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
    locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters;
    locationManager.distanceFilter = kCLLocationAccuracyHundredMeters;
    locationManager.delegate = self;
    [locationManager requestAlwaysAuthorization];
    [locationManager startUpdatingLocation];
}

-(void)getLocationWithBlock:(void (^)(CLLocation *))block{
    
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
    CLLocation *location = [locations lastObject];
    CLGeocoder *coder = [[CLGeocoder alloc] init];
    NSString *address;
    
    [coder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error) {
        CLPlacemark *mark = [placemarks lastObject];
        // NSLog(@"%@", mark.addressDictionary);
       // address = mark.addressDictionary[@"City"];
    }];
    
    [locationManager pausesLocationUpdatesAutomatically];
}

-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
//    [[[UIAlertView alloc] initWithTitle:@"Location error"
//                                message:[NSString stringWithFormat:@"Error: %@", error]
//                               delegate:nil
//                      cancelButtonTitle:@"OK"
//                      otherButtonTitles:nil, nil]
//     show];
}
@end
