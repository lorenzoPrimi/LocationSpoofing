//
//  LocationSwizzler.m
//  LocationSpoofing
//
//  Created by Lorenzo Primiterra on 22/05/2019.
//  Copyright © 2019 Lorenzo Primiterra. All rights reserved.
//

#import "LocationSwizzler.h"
#import <CoreLocation/CoreLocation.h>

@implementation LocationSwizzler

static CLLocationCoordinate2D curLocation = {41.9010032,12.499715};

static Method originalMethod;
static  Method swizzleMethod;

static CLLocationManager *originalDelegate;

+(CLLocationCoordinate2D)currentLocation
{ @synchronized(self)
    {
        return curLocation;
    }
}

+(void)setCurrentLocation:(CLLocationCoordinate2D)val
{    @synchronized(self)
    {
        curLocation = val;
    }
}

+(void)turnOnSwizzleForCoordinate
{
    NSLog(@"turnOnSwizzle...");    
    Method m1 = class_getInstanceMethod([CLLocation class], @selector(coordinate));
    Method m2 = class_getInstanceMethod(self, @selector(fakeCoordinate));
    method_exchangeImplementations(m1, m2);
}

-(CLLocationCoordinate2D)fakeCoordinate
{
    NSLog(@"fakeCoordinate");
    return LocationSwizzler.currentLocation;
}
@end
