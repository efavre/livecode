//
//  OTAdvertiserService.m
//  iBeaconAdvertiser
//
//  Created by Stéphane Prohaszka on 03/04/2014.
//  Copyright (c) 2014 OCTO. All rights reserved.
//

#import "OTAdvertiserService.h"

@import CoreLocation;
@import CoreBluetooth;

@interface OTAdvertiserService()

@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, strong) CBPeripheralManager *peripheralManager;
@property (nonatomic, strong) CLBeaconRegion *beaconRegion;

@end

static NSString * const kBeaconUUID = @"9D155204-E815-4C37-B625-BCB3E41A78FF";

@implementation OTAdvertiserService

+ (instancetype)sharedService
{
    static OTAdvertiserService *service;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        service = [[OTAdvertiserService alloc]init];
        service.peripheralManager = [[CBPeripheralManager alloc] initWithDelegate:service queue:nil];
        service.locationManager = [[CLLocationManager alloc] init];
    });
    
    return service;
}

- (BOOL)isBLEAvailable
{
    return self.peripheralManager.state != CBPeripheralManagerStateUnsupported;
}

- (void)activation
{
    if (!self.peripheralManager.isAdvertising)
    {
        NSUUID *uuid = [[NSUUID alloc] initWithUUIDString:kBeaconUUID];
        self.beaconRegion = [[CLBeaconRegion alloc] initWithProximityUUID:uuid
                                                               identifier:@"iPhone"];
        
        // For the time being, the power can be leave to the default one (-57db for 1 meter).
        NSMutableDictionary *data = [self.beaconRegion peripheralDataWithMeasuredPower:nil];
        [self.peripheralManager startAdvertising:data];
    }
    else
    {
        [self.peripheralManager stopAdvertising];
    }
}

- (void)peripheralManagerDidUpdateState:(CBPeripheralManager *)peripheral
{
    // Not necessary here...
}

@end
