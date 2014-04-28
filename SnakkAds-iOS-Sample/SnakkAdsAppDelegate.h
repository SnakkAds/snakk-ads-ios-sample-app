//
//  SnakkAdsAppDelegate.h
//  SnakkAds-iOS-Sample
//
//  Created by Carl Zornes on 12/2/13.
//  Copyright (c) 2013 Phunware. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface SnakkAdsAppDelegate : UIResponder <UIApplicationDelegate, CLLocationManagerDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (retain, nonatomic) CLLocationManager *locationManager;

@end
