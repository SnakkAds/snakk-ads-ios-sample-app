//
//  SnakkAdsSecondViewController.m
//  SnakkAds-iOS-Sample
//
//  Created by Carl Zornes on 12/2/13.
//  Copyright (c) 2013 Phunware. All rights reserved.
//

#import "SnakkAdsAppDelegate.h"
#import "SnakkAdsInterstitialExampleViewController.h"
#import <SnakkAds/SKAds.h>

//*************************************
// Replace with your valid ZONE_ID here.
#define ZONE_ID_IPHONE @"50957"
#define ZONE_ID_IPAD @"50979"
#define C_ID_IPHONE @"312009"
#define C_ID_IPAD @"312025"

@interface SnakkAdsInterstitialExampleViewController ()<UIWebViewDelegate>
@property BOOL isShowingInterstitial;
@end

@implementation SnakkAdsInterstitialExampleViewController


@synthesize interstitialAd;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.hapticgeneration.com.au"]]];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    if (!self.isShowingInterstitial){
        [self loadInterstitial];
        self.isShowingInterstitial = YES;
    }
}


- (void)loadInterstitial{
    self.interstitialAd = [[SKAdsInterstitialAd alloc] init];
    self.interstitialAd.delegate = self;
    self.interstitialAd.animated = YES;
  
    NSString * zoneID = (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) ? ZONE_ID_IPAD : ZONE_ID_IPHONE;
    NSString * cID = (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) ? C_ID_IPAD : C_ID_IPHONE;
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys: cID, @"cid", nil];
    SKAdsRequest *request = [SKAdsRequest requestWithAdZone:zoneID andCustomParameters:params];
    SnakkAdsAppDelegate *myAppDelegate = (SnakkAdsAppDelegate *)([[UIApplication sharedApplication] delegate]);
    [request updateLocation:myAppDelegate.locationManager.location];
    [self.interstitialAd loadInterstitialForRequest:request];
}

#pragma mark -
#pragma mark SKAdsInterstitialAdDelegate methods

- (void)skInterstitialAd:(SKAdsInterstitialAd *)interstitialAd didFailWithError:(NSError *)error {
    NSLog(@"Error: %@", error.localizedDescription);
    UIAlertView *errorAlert = [[UIAlertView alloc] initWithTitle:@"Error showing Interstitial" message:error.localizedDescription delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [errorAlert show];
}

- (void)skInterstitialAdDidUnload:(SKAdsInterstitialAd *)interstitialAd {
    NSLog(@"Ad did unload");
    self.interstitialAd = nil; // don't reuse interstitial ad!
}

- (void)skInterstitialAdWillLoad:(SKAdsInterstitialAd *)interstitialAd {
    NSLog(@"Ad will load");
}

- (void)skInterstitialAdDidLoad:(SKAdsInterstitialAd *)interstitialAd {
    NSLog(@"Ad did load");
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
    [self.interstitialAd presentFromViewController:self];
}

- (BOOL)skInterstitialAdActionShouldBegin:(SKAdsInterstitialAd *)interstitialAd willLeaveApplication:(BOOL)willLeave {
    NSLog(@"Ad action should begin");
    return YES;
}

- (void)skInterstitialAdActionDidFinish:(SKAdsInterstitialAd *)interstitialAd {
    NSLog(@"Ad action did finish");
    self.isShowingInterstitial = NO;
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
}

#pragma mark -
#pragma mark UIWebViewDelegate
-(void)webViewDidFinishLoad:(UIWebView *)webView{
    [self.activityIndicatorWebView stopAnimating];
}

-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    [self.activityIndicatorWebView stopAnimating];
}
@end