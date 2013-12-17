//
//  AppDelegate.m
//  e rcv
//
//  Created by Charles Yang on 31/10/13.
//  Copyright (c) 2013 Charles Yang. All rights reserved.
//

#import "AppDelegate.h"
#import "BeaconMonitoringService.h"

NSString *const kUUID = @"B9407F30-F5F8-466E-AFF9-25556B57FE6D";
NSString *const kBeaconId = @"com.rippl.asia";
NSString *const DidRangeNearBeaconNotification = @"DidRangeNearBeaconNotification";

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    UILocalNotification *notification = [launchOptions objectForKey:UIApplicationLaunchOptionsLocalNotificationKey];
    
    if (notification != nil) {
        NSLog(@"UIApplicationLaunchOptionsLocalNotificationKey...");
        [BeaconMonitoringService sharedInstance].notifSent = YES;
        UITabBarController *tabController = (UITabBarController *)self.window.rootViewController;
        tabController.selectedIndex = 0;
    }
    
    _beaconManager = [[CLLocationManager alloc] init];
    _beaconManager.desiredAccuracy = kCLLocationAccuracyBest;
    _beaconManager.delegate = self;
    //_beaconManager.avoidUnknownStateBeacons = YES;
    
    _compMinVal = 0;
    
    [[BeaconMonitoringService sharedInstance] startMonitoringBeaconWithIdentifier:kBeaconId uuid:kUUID major:0 minor:0 onEntry:YES onExit:YES onDisplay:YES];
    
    return YES;
}

- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification
{
    NSString *notifType = notification.userInfo[@"NotifType"];
    //NSLog(@"didReceiveLocalNotification - %@", notifType);
    
    if ([notifType isEqualToString:@"Entry"]) {
        ;
    }
    else if ([notifType isEqualToString:@"Exit"]) {
        ;
    }
    else if ([notifType isEqualToString:@"BcnRanged"]) {
        
        NSString *minor = notification.userInfo[@"Minor"];
        
        /*
        ESTBeacon *b = notification.userInfo[@"beacon"];
        [BeaconMonitoringService sharedInstance].bMinorVal = [b.ibeacon.minor integerValue];
        [BeaconMonitoringService sharedInstance].vcPushed = YES;
        */
    
        //[BeaconMonitoringService sharedInstance].vcPushed = YES;
        //[BeaconMonitoringService sharedInstance].bMinorVal = [notifType intValue];
        [BeaconMonitoringService sharedInstance].bMinorVal = [minor intValue];
        
        UITabBarController *tabController = (UITabBarController *)self.window.rootViewController;
    
        if (tabController.selectedIndex != 0) {
            [BeaconMonitoringService sharedInstance].notifSent = YES;
            tabController.selectedIndex = 0;
        }
        else {
            //[[NSNotificationCenter defaultCenter] postNotificationName:DidRangeNearBeaconNotification object:self userInfo:nil];
            [[NSNotificationCenter defaultCenter] postNotificationName:DidRangeNearBeaconNotification object:self userInfo:notification.userInfo];
        }
    
    
        //[[NSNotificationCenter defaultCenter] postNotificationName:DidRangeNearBeaconNotification object:self userInfo:notification.userInfo];
    
        //[[[[self window] rootViewController] navigationController] pushViewController:tabController animated:YES];
    }
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)locationManager:(CLLocationManager *)manager didStartMonitoringForRegion:(CLRegion *)region
{
    NSLog(@"didStartMonitoringForRegion - %@", region.identifier);
    [_beaconManager requestStateForRegion:region];
}

//-(void)beaconManager:(ESTBeaconManager *)manager didDetermineState:(CLRegionState)state forRegion:(ESTBeaconRegion *)region
- (void)locationManager:(CLLocationManager *)manager didDetermineState:(CLRegionState)state forRegion:(CLRegion *)region
{
    //NSLog(@"didDetermineState");
    if ([region isKindOfClass:[CLBeaconRegion class]]) {
        CLBeaconRegion *beaconRegion = (CLBeaconRegion *) region;
        
        if (state == CLRegionStateInside)
        {
            NSLog(@"didDetermineState:forRegion - INSIDE %@", beaconRegion.identifier);
            [_beaconManager startRangingBeaconsInRegion:beaconRegion];
            [_beaconManager startUpdatingLocation];
        }
        else if (state == CLRegionStateOutside)
        {
            NSLog(@"didDetermineState:forRegion - OUTSIDE %@", beaconRegion.identifier);
            [_beaconManager stopRangingBeaconsInRegion:beaconRegion];
            [_beaconManager stopUpdatingLocation];
        }
    }
}

//-(void)beaconManager:(ESTBeaconManager *)manager didEnterRegion:(ESTBeaconRegion *)region
- (void)locationManager:(CLLocationManager *)manager didEnterRegion:(CLRegion *)region
{
    // CHECK WHETHER THIS IS THE REGION WE ARE MONITORING
    // >> Not set in receiver currently, does receiver need to know this for estimote?
    
    // if (region.proximityUUID isEqual:_uuid)
    
    if ([region isKindOfClass:[CLBeaconRegion class]]) {
        CLBeaconRegion *beaconRegion = (CLBeaconRegion *) region;
    
        NSLog(@"didEnterRegion - %@", beaconRegion.identifier);
    
        //[_beaconManager startRangingBeaconsInRegion:beaconRegion];
        //[_beaconManager startUpdatingLocation];
        
        // present local notification
        UILocalNotification *notification = [[UILocalNotification alloc] init];
        notification.alertBody = @"Welcome to Ikea!";
        notification.soundName = UILocalNotificationDefaultSoundName;
        NSDictionary *infoDict = [NSDictionary dictionaryWithObject:@"Entry" forKey:@"NotifType"];
        notification.userInfo = infoDict;
        [[UIApplication sharedApplication] presentLocalNotificationNow:notification];
    }
}

//-(void)beaconManager:(ESTBeaconManager *)manager didExitRegion:(ESTBeaconRegion *)region
-(void) locationManager:(CLLocationManager *)manager didExitRegion:(CLRegion *)region
{
    // if (region.proximityUUID isEqual:_uuid)
    
    if ([region isKindOfClass:[CLBeaconRegion class]]) {
        CLBeaconRegion *beaconRegion = (CLBeaconRegion *) region;
        
        NSLog(@"didExitRegion - %@", beaconRegion.identifier);
    
        [_beaconManager stopRangingBeaconsInRegion:beaconRegion];
        //[_beaconManager stopUpdatingLocation];
        
        //[BeaconMonitoringService sharedInstance].vcPushed = NO;
        [BeaconMonitoringService sharedInstance].notifSent = NO;
        [BeaconMonitoringService sharedInstance].bMinorVal = 0;
        
        // present local notification
        UILocalNotification *notification = [[UILocalNotification alloc] init];
        notification.alertBody = @"Goodbye!";
        notification.soundName = UILocalNotificationDefaultSoundName;
        NSDictionary *infoDict = [NSDictionary dictionaryWithObject:@"Exit" forKey:@"NotifType"];
        notification.userInfo = infoDict;
        [[UIApplication sharedApplication] presentLocalNotificationNow:notification];
    }
}

//-(void)beaconManager:(ESTBeaconManager *)manager didRangeBeacons:(NSArray *)beacons inRegion:(ESTBeaconRegion *)region
-(void) locationManager:(CLLocationManager *)manager didRangeBeacons:(NSArray *)beacons inRegion:(CLBeaconRegion *)region
{
    //NSLog(@"didRangeBeacons:inRegion - %@", region.identifier);
    
    // if (region.proximityUUID isEqual:_uuid)
    
    // >> TO SMOOTH SPIKES & DIPS BEFORE POSTING NOTIFICATION
    
    
    if([beacons count] > 0)
    {
        NSLog(@"all beacons ranged... %@", beacons);
        
        
        // UNKNOWN - 0, IMMEDIATE - 1, NEAR - 2, FAR - 3
        //ESTBeacon* closestBeacon = [beacons objectAtIndex:0];
        //CLBeacon *closestBeacon = [beacons objectAtIndex:0];
        CLBeacon *closestBeacon;
     
        
        for (int i=0; i < beacons.count; i++) {
            CLBeacon *tBeacon = [beacons objectAtIndex:i];
            
            if (tBeacon.proximity == CLProximityNear || tBeacon.proximity == CLProximityImmediate)
            {
                closestBeacon = [beacons objectAtIndex:i];
                NSLog(@"closest beacon found....");
                break;
            }
        }
        
        //if (closestBeacon.proximity == CLProximityUnknown)
        //    NSLog(@"MINOR - %@, UNKNOWN", closestBeacon.minor);//, closestBeacon.proximity);
        //else if (closestBeacon.proximity == CLProximityFar)
        //    NSLog(@"MINOR - %@, FAR", closestBeacon.minor);//, closestBeacon.proximity);
        //else if (closestBeacon.proximity == CLProximityNear)
        //    NSLog(@"MINOR - %@, NEAR", closestBeacon.minor);//, closestBeacon.proximity);
        //else if (closestBeacon.proximity == CLProximityImmediate)
        //    NSLog(@"MINOR - %@, IMMEDIATE", closestBeacon.minor);//, closestBeacon.proximity);
     
        //if (closestBeacon)
        if (closestBeacon.proximity == CLProximityNear || closestBeacon.proximity == CLProximityImmediate)
        //if (closestBeacon.proximity == CLProximityImmediate)
        {
            //NSLog(@"proximity - %d, major - %@, minor - %@, accuracy - %f, rssi - %i, identifier - %@", closestBeacon.proximity, closestBeacon.major, closestBeacon.minor, closestBeacon.accuracy, closestBeacon.rssi, region.identifier);
            
            if (_compMinVal != [closestBeacon.minor integerValue] && [closestBeacon.minor integerValue] != 0)
            {
                NSLog(@">>>>>>>>>>>>>>>>> MINOR: %@, ACCUR: %f, POWER: %i", closestBeacon.minor, closestBeacon.accuracy, closestBeacon.rssi);
                
                _compMinVal = [closestBeacon.minor integerValue];
                
                UILocalNotification *notification = [[UILocalNotification alloc] init];
                
                if ([closestBeacon.minor intValue] == 29542)
                    notification.alertBody = @"Welcome to the lamps department!";
                else if ([closestBeacon.minor intValue] == 29846)
                    notification.alertBody = @"FORSÅ may suit your needs.";
                else if ([closestBeacon.minor intValue] == 46948)
                    notification.alertBody = @"STRÅLA is at 20%% off today!";
                
                notification.soundName = UILocalNotificationDefaultSoundName;
                
                NSDictionary *infoDict = [NSDictionary dictionaryWithObjectsAndKeys:@"BcnRanged", @"NotifType", region.identifier, @"Region", [closestBeacon.major stringValue], @"Major", [closestBeacon.minor stringValue], @"Minor", nil];
                notification.userInfo = infoDict;
                
                [[UIApplication sharedApplication] presentLocalNotificationNow:notification];
                //[[NSNotificationCenter defaultCenter] postNotificationName:DidRangeNearBeaconNotification object:self userInfo:infoDict];
            }
        }
        
        
         
         //UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main_iPhone" bundle: nil];
         //UITabBarController *tabController = [mainStoryboard instantiateViewControllerWithIdentifier:@"tabbar"];
         //tabController.selectedIndex = 2;
         ////[[[[self window] rootViewController] navigationController] pushViewController:tabController animated:YES];
    }
}

@end
