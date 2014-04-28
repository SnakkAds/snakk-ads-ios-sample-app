//
//  SKAdsRequest.h
//  SKAds iOS SDK
//
//  Created by Nick Penteado on 4/11/12.
//  Updated by Carl Zornes on 10/23/13.
//  Copyright (c) 2013 SKAds!. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

/**
 `SKAdsRequest` implements a standard `SKAdsRequest` into your app. This is required for all ad requests.
 */

@interface SKAdsRequest : NSObject

///---------------
/// @name Optional
///---------------

/**
 Creates the `SKAdsRequest` object with the specified Zone ID.
 
 @param zone The Zone ID for which you want to request ads.
 */
+ (SKAdsRequest *)requestWithAdZone:(NSString *)zone;

/**
 Creates the `SKAdsRequest` object with the specified Zone ID and any custom parameters.
 
 @param zone The Zone ID for which you want to request ads.
 @param theParams An `NSDictionary` with key / value pairs of custom parameters.
 */
+ (SKAdsRequest *)requestWithAdZone:(NSString *)zone andCustomParameters:(NSDictionary *)theParams;

/**
 
 Updates the `SKAdsRequest` object with the user's location information.
 
 @param location The user's current location.
 */
- (void)updateLocation:(CLLocation *)location;

/**
 Returns the custom parameter that is set in the `SKAdsRequest` object for the given key.
 
 @param key The key for which you want to see the value.
 */
- (id)customParameterForKey:(NSString *)key;

/**
 Sets the custom parameter in the `SKAdsRequest` object for the given key.
 
 @param value The value for which you want to set the key.
 @param key The key for which you want to set the value.
 */
- (id)setCustomParameter:(id)value forKey:(NSString *)key;

/**
 Removes the custom parameter in the `SKAdsRequest` object for the given key.
 
 @param key The key for which you want to remove the value.
 */
- (id)removeCustomParameterForKey:(NSString *)key;


/**
 An `NSUInteger` that sets the location precision information of the `SKAdsRequest`.
 */
@property (nonatomic, assign) NSUInteger locationPrecision;

/**
 A `BOOL` to indicate whether the `SKAdsRequest` should run in test mode.
 */
@property (nonatomic, readwrite, setter = setTestMode:) BOOL isTestMode;

@end
