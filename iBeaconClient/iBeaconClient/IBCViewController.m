//
//  DCViewController.m
//  iBeaconConsumer
//
//  Created by Eric Favre on 03/04/2014.
//  Copyright (c) 2014 Eric. All rights reserved.
//

#import "IBCViewController.h"
#import "IBCConstant.h"

@interface IBCViewController ()
@property(strong, nonatomic) CLLocationManager *locationManager;
@end

@implementation IBCViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self startMonitoring];
}

- (void)startMonitoring
{
    self.locationManager = [[CLLocationManager alloc] init
                            ];
    self.locationManager.delegate = self;
    NSUUID *uuid = [[NSUUID alloc] initWithUUIDString:UUID];
    CLBeaconRegion *beaconRegion = [[CLBeaconRegion alloc] initWithProximityUUID:uuid identifier:@"STP-IBEACON"];
    [self.locationManager startMonitoringForRegion:beaconRegion];
}

- (void)locationManager:(CLLocationManager *)manager didEnterRegion:(CLRegion *)region
{
    self.statusLabel.text = @"Entrée !";
    [self.locationManager startRangingBeaconsInRegion:(CLBeaconRegion *) region];
    [self notify];
}

-(void)locationManager:(CLLocationManager *)manager didExitRegion:(CLRegion *)region
{
    self.statusLabel.text = @"Sortie !";
}

-(void)locationManager:(CLLocationManager *)manager didRangeBeacons:(NSArray *)beacons inRegion:(CLBeaconRegion *)region
{
    CLBeacon *beacon = [beacons lastObject];
    switch (beacon.proximity) {
        case CLProximityImmediate:
            self.view.backgroundColor = [UIColor greenColor];
            break;
        case CLProximityNear:
            self.view.backgroundColor = [UIColor blueColor];
            break;
        case CLProximityFar:
            self.view.backgroundColor = [UIColor redColor];
            break;
        default:
            self.view.backgroundColor = [UIColor whiteColor];
            break;
    }
}

- (void)notify
{
    UILocalNotification *notification = [[UILocalNotification alloc] init];
    notification.alertBody = @"Entrée !";
    notification.alertAction = @"Ouvrir";
    [[UIApplication sharedApplication] scheduleLocalNotification:notification];
}

@end
