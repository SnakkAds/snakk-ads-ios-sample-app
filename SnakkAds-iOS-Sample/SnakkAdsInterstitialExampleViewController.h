//
//  SnakkAdsSecondViewController.h
//  SnakkAds-iOS-Sample
//
//  Created by Carl Zornes on 12/2/13.
//  Copyright (c) 2013 Phunware. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SnakkAds/SKAdsInterstitialAd.h>

enum {
    StateNone       = 0,
    StateLoading    = 1,
    StateError      = 2,
    StateReady      = 3,
};
typedef NSUInteger ButtonState;

@interface SnakkAdsInterstitialExampleViewController : UIViewController<SKAdsInterstitialAdDelegate>

@property (retain, nonatomic) SKAdsInterstitialAd *interstitialAd;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicatorWebView;
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end
