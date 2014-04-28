//
//  SKAdsBrowserControllerDelegate.h
//  SKAds iOS SDK
//
//
//  Updated by Carl Zornes on 10/24/13.
//  Copyright (c) 2013 SKAds!. All rights reserved.
//

@class SKAdsBrowserController;
/**
 This protocol is to be used when trying to handle actions when the user taps on an ad.
 */
@protocol SKAdsBrowserControllerDelegate <NSObject>
@required

/**
 This method is called when the web view fails to load the ad's landing page.
 */
- (void)browserControllerFailedToLoad:(SKAdsBrowserController *)browserController withError:(NSError *)error;

/**
 This method is called when the web view should load the ad's landing page.
 */
- (BOOL)browserControllerShouldLoad:(SKAdsBrowserController *)browserController willLeaveApp:(BOOL)willLeaveApp;

/**
 This method is called once the web view has loaded ad's landing page.
 */
- (void)browserControllerLoaded:(SKAdsBrowserController *)browserController willLeaveApp:(BOOL)willLeaveApp;

/**
 This method is called when the 'Done' button is pressed on the ad's landing page.
 */
- (void)browserControllerWillDismiss:(SKAdsBrowserController *)browserController;

/**
 This method is called after the web view is closed.
 */
- (void)browserControllerDismissed:(SKAdsBrowserController *)browserController;
@end
