//
//  FTLocationManagerExampleViewController.m
//  FTLocationManagerExample
//
//  Created by Lukas Kukacka on 19/11/13.
//  Copyright (c) 2013 Fuerte Int. Ltd. All rights reserved.
//

#import "FTLocationManagerExampleViewController.h"

#import <CoreLocation/CoreLocation.h>
#import "FTLocationManager.h"

@interface FTLocationManagerExampleViewController ()

@end

@implementation FTLocationManagerExampleViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"Example";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIBarButtonItem *updateLocationBarButton = [[UIBarButtonItem alloc] initWithTitle:@"Get location" style:UIBarButtonItemStyleBordered target:self action:@selector(updateLocation:)];
    self.navigationItem.leftBarButtonItem = updateLocationBarButton;
    
    self.activityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    _activityIndicatorView.hidesWhenStopped = YES;
    
    UIBarButtonItem *activityBarButton = [[UIBarButtonItem alloc] initWithCustomView:_activityIndicatorView];
    self.navigationItem.rightBarButtonItem = activityBarButton;
    
    self.textLabel = [[UILabel alloc] initWithFrame:CGRectInset(self.view.bounds, 20.0f, 80.0f)];
    _textLabel.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    _textLabel.numberOfLines = 0;
    [self.view addSubview:_textLabel];
}

#pragma mark User actions

- (void)updateLocation:(UIButton *)sender
{
    //  Disable button and show activity indicator
    self.navigationItem.leftBarButtonItem.enabled = NO;
    [_activityIndicatorView startAnimating];
    
    
    //  Get FTLocatioManager singleton instance
    FTLocationManager *locationManager = [FTLocationManager sharedManager];
    
    //  Optionaly you can change properties like error timeout and errors count threshold
    //locationManager.errorTimeout = 10;
    //locationManager.maxErrorsCount = 5;
    
    //  Ask the location manager to get current location and get notified using
    //  provided handler block
    [locationManager updateLocationWithCompletionHandler:^(CLLocation *location, NSError *error, BOOL locationServicesDisabled) {
        
        NSString *outputText;
        if (error)
        {
            //  Often cause of error is that Location services are disabled for this app
            //  BOOL passed to the completion handler is YES if this is the cause of error
            if(locationServicesDisabled) {
                outputText = [NSString stringWithFormat:@"Failed to retrieve location. Location Services are disabled for this app.\nError: %@", error];
            } else {
                outputText = [NSString stringWithFormat:@"Failed to retrieve location with error: %@", error];
            }
        }
        else {
            outputText = [NSString stringWithFormat:@"Received CLLocation: %@", location];
        }
        
        _textLabel.text = outputText;
        NSLog(@"%@", outputText);
        
        self.navigationItem.leftBarButtonItem.enabled = YES;
        [_activityIndicatorView stopAnimating];
    }];
}

@end
