//
//  BeaconMonitoringService.h
//  e rcv
//
//  Created by Charles Yang on 31/10/13.
//  Copyright (c) 2013 Charles Yang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface BeaconMonitoringService : NSObject
{
    BOOL vcPushed;
    BOOL notifSent;
    int  bMinorVal;
}

@property BOOL vcPushed;
@property BOOL notifSent;
@property int bMinorVal;

+ (BeaconMonitoringService *)sharedInstance;

- (void)startMonitoringBeaconWithIdentifier:(NSString *)identifier
                                       uuid:(NSString *)uuid
                                      major:(CLBeaconMajorValue)major
                                      minor:(CLBeaconMinorValue)minor
                                    onEntry:(BOOL)entry
                                     onExit:(BOOL)exit
                                  onDisplay:(BOOL)display;

@end
