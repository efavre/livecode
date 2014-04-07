//
//  OTViewController.m
//  iBeaconAdvertiser
//
//  Created by Stéphane Prohaszka on 03/04/2014.
//  Copyright (c) 2014 OCTO. All rights reserved.
//

#import "OTViewController.h"

#import "OTAdvertiserService.h"

@interface OTViewController ()

@property (nonatomic, weak) IBOutlet UIActivityIndicatorView *activityIndicatorView;
@property (nonatomic, weak) IBOutlet UISwitch *activationSwitch;

@end

@implementation OTViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    OTAdvertiserService *service = [OTAdvertiserService sharedService];
    self.activationSwitch.enabled = [service isBLEAvailable];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)activate:(id)sender
{
    UISwitch *activateSwitch = (UISwitch*)sender;
    if (activateSwitch.isOn)
    {
        [self.activityIndicatorView startAnimating];
    }
    else
    {
        [self.activityIndicatorView stopAnimating];
    }
    
    [[OTAdvertiserService sharedService] activation];
}

@end
