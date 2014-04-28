//
//  SnakkAdsAdPromptExampleViewController.m
//  SnakkAds-iOS-Sample
//
//  Created by Carl Zornes on 12/2/13.
//  Copyright (c) 2013 Phunware. All rights reserved.
//

#import "SnakkAdsAppDelegate.h"
#import "SnakkAdsAdPromptExampleViewController.h"
#import <SnakkAds/SKAds.h>

//*************************************
// Replace with your valid ZONE_ID here.
#define ZONE_ID_IPHONE @"50959"
#define ZONE_ID_IPAD @"50981"

@interface SnakkAdsAdPromptExampleViewController ()

@end

@implementation SnakkAdsAdPromptExampleViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.hapticgeneration.com.au"]]];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self simpleExample];
}

#pragma mark -
#pragma mark SKAdsAdPrompt Example code
- (void)simpleExample{
    NSString * zoneID = (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) ? ZONE_ID_IPAD : ZONE_ID_IPHONE;
    SKAdsRequest *request = [SKAdsRequest requestWithAdZone:zoneID];
    SKAdsAdPrompt *prompt = [[SKAdsAdPrompt alloc] initWithRequest:request];
    [prompt showAsAlert];
}


- (void)loadAdPrompt {
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
    //                            @"test", @"mode", // enable test mode to test AdPrompts in your app
                            nil];
    NSString * zoneID = (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) ? ZONE_ID_IPAD : ZONE_ID_IPHONE;
    SKAdsRequest *request = [SKAdsRequest requestWithAdZone:zoneID andCustomParameters:params];
    SnakkAdsAppDelegate *myAppDelegate = (SnakkAdsAppDelegate *)([[UIApplication sharedApplication] delegate]);
    [request updateLocation:myAppDelegate.locationManager.location];
    skAdPrompt = [[SKAdsAdPrompt alloc] initWithRequest:request];
    skAdPrompt.delegate = self;
    skAdPrompt.showLoadingOverlay = NO;
}



- (void)skAdPrompt:(SKAdsAdPrompt *)adPrompt didFailWithError:(NSError *)error {
    NSLog(@"Error showing AdPrompt: %@", error);
    UIAlertView *errorAlert = [[UIAlertView alloc] initWithTitle:@"Error showing AdPrompt" message:error.localizedDescription delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [errorAlert show];
    [self cleanupAdPrompt];
}

- (void)skAdPromptWasDeclined:(SKAdsAdPrompt *)adPrompt {
    NSLog(@"AdPrompt was DECLINED!");
    [self cleanupAdPrompt];
}

- (void)skAdPromptDidLoad:(SKAdsAdPrompt *)adPrompt {
    NSLog(@"AdPrompt loaded!");
}

- (void)skAdPromptWasDisplayed:(SKAdsAdPrompt *)adPrompt {
    NSLog(@"AdPrompt displayed!");
}

- (BOOL)skAdPromptActionShouldBegin:(SKAdsAdPrompt *)adPrompt willLeaveApplication:(BOOL)willLeave {
    NSString *strWillLeave = willLeave ? @"Leaving app" : @"loading internally";
    NSLog(@"AdPrompt was accepted, loading app/advertisement... %@", strWillLeave);
    return YES;
}

- (void)skAdPromptActionDidFinish:(SKAdsAdPrompt *)adPrompt {
    NSLog(@"AdPrompt Action finished!");
    [self cleanupAdPrompt];
}

- (void)cleanupAdPrompt {
    skAdPrompt = nil;
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
