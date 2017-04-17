//
//  AppDelegate.h
//  At the Wheel
//
//  Created by Negulus on 4/12/13.
//  Copyright (c) 2013 Negulus. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate, UIAccelerometerDelegate>
{
    float accel_x;
    float accel_y;
    float accel_z;
}

@property (strong, nonatomic) UIWindow *window;

@property (assign, nonatomic, readwrite) float accel_x;
@property (assign, nonatomic, readwrite) float accel_y;
@property (assign, nonatomic, readwrite) float accel_z;

@end
