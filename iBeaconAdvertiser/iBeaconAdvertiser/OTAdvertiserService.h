//
//  OTAdvertiserService.h
//  iBeaconAdvertiser
//
//  Created by Stéphane Prohaszka on 03/04/2014.
//  Copyright (c) 2014 OCTO. All rights reserved.
//

#import <Foundation/Foundation.h>

@import CoreBluetooth;

@interface OTAdvertiserService : NSObject <CBPeripheralManagerDelegate>

+ (instancetype)sharedService;

/**
 * Check if the device support Bluetooth Low Energy.
 * @return YES if BLE is device is Bluetooth Smart Ready.
 */
- (BOOL)isBLEAvailable;

/**
 * Switch activation and deactivation of the advertising.
 */
- (void)activation;

@end
