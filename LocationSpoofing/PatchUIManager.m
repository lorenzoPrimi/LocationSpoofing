//
//  PatchUIManager.m
//  LocationSpoofing
//
//  Created by Lorenzo Primiterra on 22/05/2019.
//  Copyright © 2019 Lorenzo Primiterra. All rights reserved.
//

#import "PatchUIManager.h"

@implementation PatchUIManager

- (id)init {
    self = [super init];
    hijackingSubviews = [[NSMutableArray alloc]init];
    [self setupViewsForLoading];
    return self;
}

-(void)setupViewsForLoading
{
    UIWindow *window = [[[UIApplication sharedApplication] windows] objectAtIndex:0];
    UILabel *label =  [[UILabel alloc]initWithFrame:CGRectMake(0, 80, window.frame.size.width, 50)];
    [label setBackgroundColor:[UIColor lightGrayColor]];
    [label setBackgroundColor:[UIColor colorWithRed:0 green:1 blue:1 alpha:0.5]];
    [label setTextAlignment:NSTextAlignmentCenter];
    [label setTag:29999];
    CLLocationCoordinate2D currentCoordinate =  LocationSwizzler.currentLocation;
    [label setText:[NSString stringWithFormat:@"Current position %f %f",currentCoordinate.latitude, currentCoordinate.longitude]];
    [hijackingSubviews addObject:label];
    
    UIImage *buttonImage = [self imageFromColor:CGSizeMake(40, 40) imageColor:[UIColor colorWithRed:1 green:1 blue:0 alpha:0.5]];
    
    UIButton *setButton =  [[UIButton alloc]initWithFrame:CGRectMake(window.frame.size.width-150, 150, 150, 40)];
    [setButton setTitle:@"Set Location" forState:UIControlStateNormal];
    [setButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    setButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    [setButton setBackgroundColor:[UIColor blueColor]];
    [setButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [setButton setTag:29994];
    [setButton addTarget:self.class action:@selector(setCoord) forControlEvents:UIControlEventTouchUpInside];
    [hijackingSubviews addObject:setButton];
    
    UIButton *nButton =  [[UIButton alloc]initWithFrame:CGRectMake(40, 150, 40, 40)];
    [nButton setTitle:@"N" forState:UIControlStateNormal];
    [nButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    nButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    [nButton setImage:buttonImage forState:UIControlStateNormal];
    [nButton setTag:29998];
    [nButton addTarget:self.class action:@selector(moveN) forControlEvents:UIControlEventTouchUpInside];
    [hijackingSubviews addObject:nButton];
    
    UIButton *wButton =  [[UIButton alloc]initWithFrame:CGRectMake(0, 190, 40, 40)];
    [wButton setTitle:@"W" forState:UIControlStateNormal];
    [wButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    wButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    [wButton setImage:buttonImage forState:UIControlStateNormal];
    [wButton setTag:29997];
    [wButton addTarget:self.class action:@selector(moveW) forControlEvents:UIControlEventTouchUpInside];
    [hijackingSubviews addObject:wButton];
    
    UIButton *sButton =  [[UIButton alloc]initWithFrame:CGRectMake(40, 230, 40, 40)];
    [sButton setTitle:@"S" forState:UIControlStateNormal];
    [sButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    nButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    [sButton setImage:buttonImage forState:UIControlStateNormal];
    [sButton setTag:29996];
    [sButton addTarget:self.class action:@selector(moveS) forControlEvents:UIControlEventTouchUpInside];
    [hijackingSubviews addObject:sButton];
    
    UIButton *eButton =  [[UIButton alloc]initWithFrame:CGRectMake(80, 190, 40, 40)];
    [eButton setTitle:@"E" forState:UIControlStateNormal];
    [eButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    eButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    [eButton setImage:buttonImage forState:UIControlStateNormal];
    [eButton setTag:29995];
    [eButton addTarget:self.class action:@selector(moveE) forControlEvents:UIControlEventTouchUpInside];
    [hijackingSubviews addObject:eButton];
}

+(void)hijackAppWindow
{
    for (int i=0; i <= 20; i++) {
        // Delay 2 seconds
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [[[[self class] alloc]init] displayDisplayLabel];
        });
    }
}

+(void)setLabelPosition{
    UIWindow *window = [[[UIApplication sharedApplication] delegate] window];
    //UIWindow *window = [[[UIApplication sharedApplication] windows] objectAtIndex:0];
    UIView *existingHijackView = [window viewWithTag:29999];
    if (existingHijackView != nil)
    {
        CLLocationCoordinate2D currentCoordinate =  LocationSwizzler.currentLocation;
        [(UILabel*)existingHijackView setText:[NSString stringWithFormat:@"Current position %f %f",currentCoordinate.latitude, currentCoordinate.longitude]];
    }
}

-(void)displayDisplayLabel
{
    //UIWindow *window = [[[UIApplication sharedApplication] windows] objectAtIndex:0];
    UIWindow *window = [[[UIApplication sharedApplication] delegate] window];
    for (UIView *hijackingView in hijackingSubviews) {
        UIView *existingHijackView = [window viewWithTag:hijackingView.tag];
        if (existingHijackView != nil)
        {
            [existingHijackView removeFromSuperview];
        }
        [window addSubview:hijackingView];
    }
}

-(UIImage*)imageFromColor:(CGSize)size imageColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContext(size);
    [[UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:3]addClip];
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

+(void)moveN
{
    CLLocationCoordinate2D currentCoordinate =  LocationSwizzler.currentLocation;
    currentCoordinate.latitude = currentCoordinate.latitude+0.0001;
    LocationSwizzler.currentLocation = currentCoordinate;
    [self setLabelPosition];
}

+(void)moveW
{
    CLLocationCoordinate2D currentCoordinate =  LocationSwizzler.currentLocation;
    currentCoordinate.longitude = currentCoordinate.longitude-0.0001;
    LocationSwizzler.currentLocation = currentCoordinate;
    [self setLabelPosition];
}

+(void)moveS
{
    CLLocationCoordinate2D currentCoordinate =  LocationSwizzler.currentLocation;
    currentCoordinate.latitude = currentCoordinate.latitude-0.0001;
    LocationSwizzler.currentLocation = currentCoordinate;
    [self setLabelPosition];
}

+(void)moveE
{
    CLLocationCoordinate2D currentCoordinate =  LocationSwizzler.currentLocation;
    currentCoordinate.longitude = currentCoordinate.longitude+0.0001;
    LocationSwizzler.currentLocation = currentCoordinate;
    [self setLabelPosition];
}

+ (void)setCoord{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Set coords" message:nil preferredStyle:UIAlertControllerStyleAlert];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField){
        textField.placeholder = @"lat,lon";
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *addAction = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:^( UIAlertAction *action ) {
        NSArray *textFields = alertController.textFields;
        UITextField *alertField = textFields[0];
        if ([alertField.text length] > 0){
            NSArray *items = [alertField.text componentsSeparatedByString:@","];
            double lat = [items[0] doubleValue];
            double lon = [items[1] doubleValue];
            CLLocationCoordinate2D currentCoordinate =  LocationSwizzler.currentLocation;
            currentCoordinate.longitude = lon;
            currentCoordinate.latitude = lat;
            LocationSwizzler.currentLocation = currentCoordinate;
            [self setLabelPosition];
        }
    }];
    [alertController addAction:addAction];
    [alertController addAction:cancelAction];
    UIWindow *window = [[[UIApplication sharedApplication] delegate] window];
    [window.rootViewController presentViewController:alertController animated:YES completion:nil];
}
@end
