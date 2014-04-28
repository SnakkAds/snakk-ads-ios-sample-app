//
//  VideoInterstitialrViewController.m
//  SnakkAds-iOS-Sample
//
//  Created by Carl Zornes on 10/28/13.
//
//

#import "SnakkAdsVideoExampleViewController.h"
#import <SnakkAds/TVASTAd.h>
#import <SnakkAds/SKAdsVideoInterstitialAd.h>

//*************************************
// Replace with your valid ZONE_ID here.
#define ZONE_ID_IPHONE @"52913"
#define ZONE_ID_IPAD @"52915"

@interface SnakkAdsVideoExampleViewController ()<UIWebViewDelegate>

@property BOOL isShowingVideo;
@end

@implementation SnakkAdsVideoExampleViewController

@synthesize videoAd = _videoAd;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    _videoAd = [[SKAdsVideoInterstitialAd alloc] init];
    _videoAd.delegate = self;
    
    //Optional... override the presentingViewController (defaults to the delegate)
    //_videoAd.presentingViewController = self;
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.hapticgeneration.com.au"]]];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    if (!self.isShowingVideo){
        [self requestAds];
        self.isShowingVideo = YES;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)requestAds {    
    // Create an adsRequest object and request ads from the ad server with your own ZONE_ID
    NSString * zoneID = (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) ? ZONE_ID_IPAD : ZONE_ID_IPHONE;
    TVASTAdsRequest *request = [TVASTAdsRequest requestWithAdZone:zoneID];
    [_videoAd requestAdsWithRequestObject:request];
    
    //If you want to specify the type of video ad you are requesting, use the call below.
    //[_videoAd requestAdsWithRequestObject:request andVideoType:SKAdsVideoTypeMidroll];
}

- (void)skVideoInterstitialAdDidFinish:(SKAdsVideoInterstitialAd *)videoAd {
    NSLog(@"Override point for resuming your app's content.");
    [_videoAd unloadAdsManager];
    self.isShowingVideo = NO;
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
}

- (void)viewDidUnload {
    [_videoAd unloadAdsManager];
    [super viewDidUnload];
}

- (void)skVideoInterstitialAdDidLoad:(SKAdsVideoInterstitialAd *)videoAd {
    NSLog(@"We received an ad... now show it.");
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
    [videoAd playVideoFromAdsManager];
}

- (void)skVideoInterstitialAdDidFail:(SKAdsVideoInterstitialAd *)videoAd withErrorString:(NSString *)error {
    NSLog(@"%@", error);
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
