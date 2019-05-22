//
//  LocationSwizzler.h
//  LocationSpoofing
//
//  Created by Lorenzo Primiterra on 22/05/2019.
//  Copyright © 2019 Lorenzo Primiterra. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import <objc/runtime.h>

NS_ASSUME_NONNULL_BEGIN

@interface LocationSwizzler : NSObject

+(CLLocationCoordinate2D)currentLocation;
+(void)setCurrentLocation:(CLLocationCoordinate2D)val;

+(void)turnOnSwizzleForCoordinate;
-(CLLocationCoordinate2D)fakeCoordinate;

@end

NS_ASSUME_NONNULL_END
