//
//  VideoInterstitialrViewController.h
//  SnakkAds-iOS-Sample
//
//  Created by Carl Zornes on 10/28/13.
//
//

#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>
#import <UIKit/UIKit.h>
#import <SnakkAds/SKAdsVideoInterstitialAd.h>

@interface SnakkAdsVideoExampleViewController : UIViewController<SKAdsVideoInterstitialAdDelegate>

@property (nonatomic, retain) SKAdsVideoInterstitialAd *videoAd;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicatorWebView;
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end
