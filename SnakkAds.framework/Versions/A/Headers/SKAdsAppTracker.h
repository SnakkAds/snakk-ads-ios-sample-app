//
//  SKAdsAppTracker.h
//  SKAds iOS SDK
//
//  Created by Nick Penteado on 4/11/12.
//  Updated by Carl Zornes on 10/24/13.
//  Copyright (c) 2013 SKAds!. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 `SKAdsAppTracker` implements a standard `SKAdsAppTracker` into your app. This is required for all ad requests.
 */

@interface SKAdsAppTracker : NSObject

///-----------------------
/// @name Required Methods
///-----------------------

/**
 This method creates the shared app tracker.
 */
+ (SKAdsAppTracker *)sharedAppTracker;

/**
 This method registers your application with the ad server.
 */
- (void)reportApplicationOpen;

///---------------
/// @name Other Methods
///---------------

///**
// Returns 'MaaSAdvertising'
// */
//+ (NSString *)serviceName;

@end
