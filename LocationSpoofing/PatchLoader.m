//
//  PatchLoader.m
//  PatchGPS
//
//  Created by Lorenzo Primiterra on 22/05/2019.
//  Copyright © 2019 Lorenzo Primiterra. All rights reserved.
//

#import "PatchLoader.h"
#import "LocationSwizzler.h"
#import "PatchUIManager.h"

@implementation PatchLoader

static void __attribute__((constructor)) initialize(void){
    NSLog(@"==== Code Injection in Action====");
    [LocationSwizzler turnOnSwizzleForCoordinate];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 2 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        static PatchUIManager *patchUIManager;
        patchUIManager = [PatchUIManager new];
        [PatchUIManager hijackAppWindow];
    });
}

@end
