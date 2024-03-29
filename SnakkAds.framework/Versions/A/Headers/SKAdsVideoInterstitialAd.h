//
//  SKAdsVideoInterstitialAd.h
//  SKAds iOS SDK
//
//  Created by Carl Zornes on 10/29/13.
//  Copyright (c) 2013 SKAds!. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>
#import <UIKit/UIKit.h>
#import "TVASTAdsRequest.h"
#import "TVASTVideoAdsManager.h"
#import "TVASTAdsLoader.h"
#import "TVASTClickTrackingUIView.h"
#import "TVASTClickThroughBrowser.h"
#import "SKAdsConstants.h"

@class SKAdsVideoInterstitialAd, FullScreenVC;

@protocol SKAdsVideoInterstitialAdDelegate <NSObject>

@required

///-----------------------
/// @name Required Methods
///-----------------------

/**
 Called when the adsLoader receives a video and is ready to play (required).
 */
- (void)skVideoInterstitialAdDidLoad:(SKAdsVideoInterstitialAd *)videoAd;

/**
 Gets called when the video ad has finished playing and the screen returns to your app.
 */
- (void)skVideoInterstitialAdDidFinish:(SKAdsVideoInterstitialAd *)videoAd;

/**
 Gets called if there are no ads to display.
 */
- (void)skVideoInterstitialAdDidFail:(SKAdsVideoInterstitialAd *)videoAd withErrorString:(NSString *)error;
@end

@interface SKAdsVideoInterstitialAd : NSObject <TVASTAdsLoaderDelegate,
TVASTClickTrackingUIViewDelegate, TVASTVideoAdsManagerDelegate,
TVASTClickThroughBrowserDelegate>

/**
 `SKAdsVideoInterstitialAd` implements a standard `SKAdsVideoInterstitialAd` into your app.
 */

///-----------------------
/// @name Required Methods
///-----------------------

/**
 Once an ad has successfully been returned from the server, the `TVASTVideoAdsManager` is created. You need to stop observing and unload the `TVASTVideoAdsManager` upon deallocating this object.
 */
- (void)unloadAdsManager;

/**
 Once `TVASTVideoAdsManager` has an ad ready to play, this is the function you need to call when you are ready to play the ad.
 */
- (void)playVideoFromAdsManager;

/**
 Instantiantes the `TVASTAdsRequest`.
 */
-(void)requestAdsWithRequestObject:(TVASTAdsRequest *)request;

///-----------------------
/// @name Optional
///-----------------------

/**
 Instantiantes the `TVASTAdsRequest` with a specified `SKAdsVideoType`.
 */
-(void)requestAdsWithRequestObject:(TVASTAdsRequest *)request andVideoType:(SKAdsVideoType)videoType;

/**
 An `id` that is used to identify the 'SKAdsVideoInterstitialAdDelegate' delegate.
 */
@property (assign, nonatomic) id<SKAdsVideoInterstitialAdDelegate> delegate;

/**
 A `TVASTVideoAdsManager` that is the manager of video ads.
 */
@property(nonatomic, retain) TVASTVideoAdsManager *videoAdsManager;

/**
 A `TVASTClickTrackingUIView` that handles touch events on the video ad.
 */
@property(nonatomic, retain) TVASTClickTrackingUIView *clickTrackingView;

/**
 The `AVPlayer` that will display the video ad.
 */
@property (nonatomic, retain) AVPlayer *adPlayer;

/**
 The `FullScreenVC` that will contain the `AVPlayer`.
 */
@property (nonatomic, retain) FullScreenVC *landscapeVC;

/**
 A `UIViewController` that is responsible for presenting the video ad (optional).
 */
@property (nonatomic, retain) UIViewController *presentingViewController;

@end
