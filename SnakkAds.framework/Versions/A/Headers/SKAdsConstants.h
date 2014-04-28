//
//  SKAdsConstants.h
//  SKAds iOS SDK
//
//  Created by Nick Penteado on 4/13/12.
//  Updated by Carl Zornes on 10/24/13.
//  Copyright (c) 2013 SKAds!. All rights reserved.
//

#ifndef SKAds_iOS_Sample_SKAdsConstants_h
#define SKAds_iOS_Sample_SKAdsConstants_h

#define SKADS_VERSION @"3.0.10"

/**
 `SKAdsAdType` defines the available ad types for interstitial ads.
 */
typedef enum {
    SKAdsBannerAdType       = 0x01,
    SKAdsFullscreenAdType   = 0x02,
    SKAdsVideoAdType        = 0x04,
    SKAdsOfferWallType      = 0x08,
} SKAdsAdType;

/**
 `SKAdsBannerHideDirection` defines the orientations in which you want to disable displaying ads.
 */
typedef enum {
    SKAdsBannerHideNone,
    SKAdsBannerHideLeft,
    SKAdsBannerHideRight,
    SKAdsBannerHideUp,
    SKAdsBannerHideDown,
} SKAdsBannerHideDirection;

/**
 `SKAdsVideoType` defines the available video types for video ads.
 */
typedef enum {
    SKAdsVideoTypeAll,
    SKAdsVideoTypePreroll,
    SKAdsVideoTypeMidroll,
    SKAdsVideoTypePostroll,
} SKAdsVideoType;

#define SKADS_PARAM_KEY_BANNER_ROTATE_INTERVAL @"RotateBannerInterval"
#define SKADS_PARAM_KEY_BANNER_ERROR_TIMEOUT_INTERVAL @"ErrorRetryInterval"

#define SKAdsDefaultLocationPrecision 6

#endif
