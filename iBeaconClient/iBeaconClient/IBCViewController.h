//
//  DCViewController.h
//  iBeaconConsumer
//
//  Created by Eric Favre on 03/04/2014.
//  Copyright (c) 2014 Eric. All rights reserved.
//

#import <UIKit/UIKit.h>
@import CoreLocation;
@import CoreBluetooth;

@interface IBCViewController : UIViewController <CLLocationManagerDelegate>
@property(weak, nonatomic) IBOutlet UILabel *statusLabel;
@end
