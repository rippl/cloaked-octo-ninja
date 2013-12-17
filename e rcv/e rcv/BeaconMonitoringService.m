//
//  BeaconMonitoringService.m
//  e rcv
//
//  Created by Charles Yang on 31/10/13.
//  Copyright (c) 2013 Charles Yang. All rights reserved.
//

#import "BeaconMonitoringService.h"
#import "AppDelegate.h"

@implementation BeaconMonitoringService {
    CLLocationManager* beaconManager;
}


+ (BeaconMonitoringService *)sharedInstance {
    static dispatch_once_t onceToken;
    static BeaconMonitoringService *_sharedInstance;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[self alloc] init];
    });
    
    return _sharedInstance;
}

- (instancetype)init {
    self = [super init];
    if (!self) {
        return nil;
    }
    
    beaconManager = [(AppDelegate *)[UIApplication sharedApplication].delegate beaconManager];
    _vcPushed = NO;
    _notifSent = NO;
    _bMinorVal = 0;
    
    return self;
}

- (void)startMonitoringBeaconWithIdentifier:(NSString *)identifier
                                 uuid:(NSString *)uuid
                                major:(CLBeaconMajorValue)major
                                minor:(CLBeaconMinorValue)minor
                              onEntry:(BOOL)entry
                               onExit:(BOOL)exit
                            onDisplay:(BOOL)display
{
    NSLog(@"startMonitoringForRegion...");
    //ESTBeaconRegion* region = [[ESTBeaconRegion alloc] initRegionWithIdentifier:identifier];
    //NSUUID *uuid = [[NSUUID alloc] initWithUUIDString:@"119104b0-d287-4e7a-8297-a42ab962c662"]; //Kontakt
    NSUUID *locUUID = [[NSUUID alloc] initWithUUIDString:uuid];
    
    // if major minor not null pass use initWithProximityUUID with major/minor
    CLBeaconRegion* region = [[CLBeaconRegion alloc] initWithProximityUUID:locUUID identifier:identifier];

    region.notifyOnEntry = entry;
    region.notifyOnExit = exit;
    region.notifyEntryStateOnDisplay = display;
    [beaconManager startMonitoringForRegion:region];
    [beaconManager startRangingBeaconsInRegion:region];
}

@end
