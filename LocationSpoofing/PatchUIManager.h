//
//  PatchUIManager.h
//  LocationSpoofing
//
//  Created by Lorenzo Primiterra on 22/05/2019.
//  Copyright © 2019 Lorenzo Primiterra. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "LocationSwizzler.h"

NS_ASSUME_NONNULL_BEGIN

@interface PatchUIManager : NSObject
{
    NSMutableArray *hijackingSubviews;
    UILabel *label;
}
+(void)hijackAppWindow;
+(void)moveN;
+(void)moveW;
+(void)moveE;
+(void)moveS;
+(void)setLabelPosition;
+(void)setCoord;
@end

NS_ASSUME_NONNULL_END
