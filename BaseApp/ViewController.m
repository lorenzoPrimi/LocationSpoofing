//
//  ViewController.m
//  BaseApp
//
//  Created by Lorenzo Primiterra on 22/05/2019.
//  Copyright © 2019 Lorenzo Primiterra. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize mapView;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.locationManager = [[CLLocationManager alloc] init];
    //self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    self.locationManager.distanceFilter = 100;
    self.locationManager.delegate = self;
    [self.locationManager requestWhenInUseAuthorization];
    [self.locationManager startUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error
{
    NSLog(@"Location service failed with error %@", error);
}

//TODO Swizzle delegate
- (void)locationManager:(CLLocationManager *)manager
     didUpdateLocations:(NSArray*)locations
{
    CLLocation *location = [locations lastObject];
    self.currentLocation = location;
    [self moveCameraToUserLocation];
}

- (IBAction)moveCameraToUserLocation {
    //set map camera to user position
    if (self.currentLocation){
        CLLocationCoordinate2D center;
        center.latitude = self.currentLocation.coordinate.latitude;
        center.longitude = self.currentLocation.coordinate.longitude;
        MKCoordinateRegion userRegion;
        userRegion.center = center;
        userRegion.span.latitudeDelta = 0.007;
        userRegion.span.longitudeDelta = 0.007;
        [mapView setRegion:userRegion];
    }
}
@end
