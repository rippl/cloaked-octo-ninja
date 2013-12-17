//
//  AppDelegate.h
//  e rcv
//
//  Created by Charles Yang on 31/10/13.
//  Copyright (c) 2013 Charles Yang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

extern NSString *const kBeaconId;
extern NSString *const DidRangeNearBeaconNotification;

@interface AppDelegate : UIResponder <UIApplicationDelegate, CLLocationManagerDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) CLLocationManager* beaconManager;
@property int compMinVal;

@end
