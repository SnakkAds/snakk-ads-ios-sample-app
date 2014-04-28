//
//  SKAdsInterstitialAd.h
//  SKAds iOS SDK
//
//  Created by Nick Penteado on 4/11/12.
//  Updated by Carl Zornes on 10/23/13.
//  Copyright (c) 2013 SKAds!. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "SKAdsBrowserControllerDelegate.h"
#import "SKAdsConstants.h"

@class SKAdsRequest, SKAdsInterstitialAd;

@protocol SKAdsInterstitialAdDelegate <NSObject>

@required
/**
 Called when a full-screen ad fails to load a new advertisement (required).
 
 @param interstitialAd The full-screen ad that received the error.
 @param error The error object that describes the problem.
 
 Although the error message informs your application about why the error occurred, your application normally does not need to display the error to the user.
 
 When an error occurs, your delegate should release the ad object.
 */
- (void)skInterstitialAd:(SKAdsInterstitialAd *)interstitialAd didFailWithError:(NSError *)error;

/**
 Called after a full-screen ad disposes of its content (required).
 
 @param interstitialAd The interstitial ad that disposed of its content.
 
 An ad object may unload its content for a number of reasons, including such cases as when an error occurs, after a user dismisses
 an advertisement that was presented modally or after an advertisement’s contents have been loaded for a long period of time.
 The ad object automatically removes its contents from the screen if it was already presented to the user.
 Your implementation of this method should release the ad object.
 */
- (void)skInterstitialAdDidUnload:(SKAdsInterstitialAd *)interstitialAd;


@optional
/**
 Called before the advertisement loads its content.
 
 @param interstitialAd The ad object that is about to load a new advertisement.
 */
- (void)skInterstitialAdWillLoad:(SKAdsInterstitialAd *)interstitialAd;

/**
 Called after the advertisement loads its content.
 
 @param interstitialAd The ad object that loaded a new advertisement.
 */
- (void)skInterstitialAdDidLoad:(SKAdsInterstitialAd *)interstitialAd;

/**
 Called before a banner view executes an action.
 
 @param interstitialAd The full-screen ad that the user tapped.
 @param willLeave YES if another application will be launched to execute the action; NO if the action is going to be executed inside your appliaction.
 
 @return Your delegate returns YES if the banner action should execute; NO to prevent the banner action from executing.
 
 When the user taps a presented advertisement, the ad’s delegate is called to inform your application that the user wants to interact with the ad.
 To allow the action to be triggered, your method should return YES; to suppress the action, your method returns NO. Your application should almost
 always allow actions to be triggered; preventing actions may alter the advertisements your application sees and reduce the revenue your application earns through SKAds.
 
 If the value of the willLeave parameter is YES and your delegate allows the advertisement to execute its action, then your application is moved to
 the background shortly after the call to this method completes.
 
 If the value of the willLeave parameter is NO, the advertisement’s interactive experience will run inside your application. To accomodate the advertisement,
 your application should disable activities that require user interaction as well as disabling any tasks or behaviors that may interfere with the advertisement.
 For example, a game might pause its game play and turn off sound effects until the user finishes interacting with the advertisement. Further, while the
 action is running, your application should also be prepared to respond to low-memory warnings by disposing of objects it can easily recreate after the
 advertisement completes its action.
 */
- (BOOL)skInterstitialAdActionShouldBegin:(SKAdsInterstitialAd *)interstitialAd willLeaveApplication:(BOOL)willLeave;

/**
 Called just before uncovering your app after once a cover action has occured.
 
 @param interstitialAd The full-screen ad that finished executing an action and will soon oncover your app.
 */
- (void)skInterstitialAdActionWillFinish:(SKAdsInterstitialAd *)interstitialAd;

/**
 Called after a banner view finishes executing an action that covered your application's user interface.
 
 @param interstitialAd The full-screen ad that finished executing an action.
 */
- (void)skInterstitialAdActionDidFinish:(SKAdsInterstitialAd *)interstitialAd;

@end

/**
 `SKAdsInterstitialAd` implements a standard `SKAdsInterstitialAd` into your app.
 */

@interface SKAdsInterstitialAd : NSObject <SKAdsInterstitialAdDelegate, SKAdsBrowserControllerDelegate>


///-----------------------
/// @name Required Methods
///-----------------------

/**
 Once a `SKAdsRequest` object is created, this function should be called to get the interstitial ad ready for your app.
 @param request The ad request with zone information and any custom parameters.
 */
- (BOOL)loadInterstitialForRequest:(SKAdsRequest *)request;

/**
 Once `- (BOOL)loadInterstitialForRequest:(SKAdsRequest *)request;` has been called and you have received a notification that the ad has loaded, this function should be called to present the ad within your app.
 @param request The ad request with zone information and any custom parameters.
 */
- (void)presentFromViewController:(UIViewController *)contoller;
//- (void)presentInView:(UIView *)view;


/**
 An `id` that is used to identify the 'SKAdsInterstitialAdDelegate' delegate.
 */
@property (assign, nonatomic) id<SKAdsInterstitialAdDelegate> delegate;

/**
 A `BOOL` to signify whether or not you want the ad to animate in or not. The default value is `TRUE`.
 */
@property (assign, nonatomic) BOOL animated;

/**
 A `BOOL` to signify whether or not you want the ad to automatically reposition to orientation changes. The default value is `TRUE`.
 */
@property (assign, nonatomic) BOOL autoReposition;

/**
 A `BOOL` to signify whether or not you want the ad to show a loading overlay once the ad is tapped. The default value is `TRUE`.
 */
@property (assign, nonatomic) BOOL showLoadingOverlay;

/**
 Override point for changing the `SKAdsAdType`. The default value is `SKAdsFullscreenAdType|SKAdsOfferWallType|SKAdsVideoAdType`.
 */
@property (assign, nonatomic) SKAdsAdType allowedAdTypes;

/**
 A readonly `BOOL` to signify whether or not the ad has loaded.
 */
@property (readonly) BOOL loaded;

/**
 The `UIViewController` that is presenting the interstitial ad.
 */
@property (assign, nonatomic) UIViewController *presentingController;

//@property (assign, nonatomic) SKAdsInterstitialControlType controlType;

@end
