//
//  FirstViewController.h
//  mySOS
//
//  Created by Marco Velluto on 06/02/13.
//  Copyright (c) 2013 algos. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MFMessageComposeViewController.h>
#import <MessageUI/MessageUI.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>
#import "MFile.h"
#import "SettingViewController.h"

@interface FirstViewController : UIViewController <UIVideoEditorControllerDelegate, MFMessageComposeViewControllerDelegate, CLLocationManagerDelegate>

@property (nonatomic, retain) MKMapView *userLocationAddMapView;


- (IBAction)pressButtonCallMe:(id)sender;
- (IBAction)pressButtonSendMessage:(id)sender;
- (IBAction)pressButtonSOS:(id)sender;

- (void)sendMessageWithNumbers:(NSArray *)numbers withText:(NSString *)text withLocation:(CLLocation *)location;

+ (CLLocation*)findCurrentLocation;

@end