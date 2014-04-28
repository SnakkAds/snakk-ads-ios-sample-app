//
//  SnakkAdsBannerSquareExampleViewController.h
//  SnakkAds-iOS-Sample
//
//  Created by Carl Zornes on 12/2/13.
//  Copyright (c) 2013 Phunware. All rights reserved.
//

#import "SnakkAdsAppDelegate.h"
#import "SnakkAdsBannerSquareExampleViewController.h"
#import <SnakkAds/SKAds.h>
#import "SnakkScreenHelper.h"

//*************************************
// Replace with your valid ZONE_ID here.
#define ZONE_ID_IPHONE @"50955"
#define ZONE_ID_IPAD @"50977"
#define C_ID_IPHONE @"312009"
#define C_ID_IPAD @"312025"


@interface SnakkAdsBannerSquareExampleViewController () <UIWebViewDelegate>

@end

@implementation SnakkAdsBannerSquareExampleViewController
@synthesize skAd;

- (void)initBannerAdvanced {
    // init banner and add to your view
    if (!skAd) {
        // don't re-define if we used IB to init the banner...
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            skAd = [[SKAdsBannerAdView alloc] initWithFrame:CGRectMake(768-300, [UIScreen mainScreen].bounds.size.height - 49 - 250 - [SnakkScreenHelper iOSTabBarOffset], 300, 250)];
        } else {
            skAd = [[SKAdsBannerAdView alloc] initWithFrame:CGRectMake(10, [UIScreen mainScreen].bounds.size.height - 45 - 250 - [SnakkScreenHelper iOSTabBarOffset], 300, 250)];
          //  skAd.clipsToBounds = YES;
        }
        
        [self.view addSubview:self.skAd];
    }
    
    UIInterfaceOrientation interfaceOrientation = [[UIApplication sharedApplication] statusBarOrientation];
    [self willRotateToInterfaceOrientation:interfaceOrientation duration:0];

    self.skAd.delegate = self;
    self.skAd.showLoadingOverlay = YES;
    
    // set the parent controller for modal browser that loads when user taps ad
    //self.skAd.presentingController = self; // only needed if tapping banner doesn't load modal browser properly
    
    NSString * zoneID = (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) ? ZONE_ID_IPAD : ZONE_ID_IPHONE;
    NSString * cID = (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) ? C_ID_IPAD : C_ID_IPHONE;
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys: cID, @"cid", nil];
    SKAdsRequest *request = [SKAdsRequest requestWithAdZone:zoneID andCustomParameters:params];
    
    // this is how you enable location updates... NOTE: only enable if your app has a good reason to know the users location (Apple will reject your app if not)
    SnakkAdsAppDelegate *myAppDelegate = (SnakkAdsAppDelegate *)([[UIApplication sharedApplication] delegate]);
    [request updateLocation:myAppDelegate.locationManager.location];
    
    // kick off banner rotation!
    [self.skAd startServingAdsForRequest:request];
}

- (void)viewDidLoad {
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self initBannerAdvanced];
    [NSTimer scheduledTimerWithTimeInterval:70 target:self selector:@selector(initBannerAdvanced) userInfo:nil repeats:YES];
    
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.hapticgeneration.com.au"]]];
}

- (void)viewDidAppear:(BOOL)animated {
    [self.skAd resume];
}

- (void)viewWillDisappear:(BOOL)animated {
    [self.skAd pause];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    // notify banner of orientation changes
    [self.skAd repositionToInterfaceOrientation:toInterfaceOrientation];
    if (toInterfaceOrientation == UIInterfaceOrientationPortrait || toInterfaceOrientation == UIInterfaceOrientationPortraitUpsideDown)
    {
        CGFloat xPos = (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) ? [UIScreen mainScreen].bounds.size.width - 300 : [UIScreen mainScreen].bounds.size.width / 2 - 150;
        CGFloat yPos = [UIScreen mainScreen].bounds.size.height - 45 - 250 - [SnakkScreenHelper iOSTabBarOffset];
        skAd.frame = CGRectMake(xPos, yPos, 300, 250);
    }
    else
    {
        CGFloat xPos = (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) ? [UIScreen mainScreen].bounds.size.height - 300 : [UIScreen mainScreen].bounds.size.height / 2 - 150;
        CGFloat yPos = [UIScreen mainScreen].bounds.size.width - 45 - 250 - [SnakkScreenHelper iOSTabBarOffset];
        skAd.frame = CGRectMake(xPos, yPos, 300, 250);
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark SKAdsBannerAdViewDelegate methods

- (void)skBannerAdViewWillLoadAd:(SKAdsBannerAdView *)bannerView {
    NSLog(@"Banner is about to check server for ad...");
}

- (void)skBannerAdViewDidLoadAd:(SKAdsBannerAdView *)bannerView {
    NSLog(@"Banner has been loaded...");
    // Banner view will display automatically if docking is enabled
    // if disabled, you'll want to show bannerView
}

- (void)skBannerAdView:(SKAdsBannerAdView *)bannerView didFailToReceiveAdWithError:(NSError *)error {
    NSLog(@"Banner failed to load with the following error: %@", error);
    // Banner view will hide automatically if docking is enabled
    // if disabled, you'll want to hide bannerView
}

- (BOOL)skBannerAdViewActionShouldBegin:(SKAdsBannerAdView *)bannerView willLeaveApplication:(BOOL)willLeave {
    NSLog(@"Banner was tapped, your UI will be covered up. %@", (willLeave ? @" !!LEAVING APP!!" : @""));
    // minimise app footprint for a better ad experience.
    // e.g. pause game, duck music, pause network access, reduce memory footprint, etc...
    return YES;
}

- (void)skBannerAdViewActionWillFinish:(SKAdsBannerAdView *)bannerView {
    NSLog(@"Banner is about to be dismissed, get ready!");
    
}

- (void)skBannerAdViewActionDidFinish:(SKAdsBannerAdView *)bannerView {
    NSLog(@"Banner is done covering your app, back to normal!");
    // resume normal app functions
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