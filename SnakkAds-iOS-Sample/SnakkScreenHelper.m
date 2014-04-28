//
//  SnakkScreenHelper.m
//  SnakkAds SDK
//
//  Created by Geoff Speirs on 9/04/2014.
//  Copyright (c) 2014 Phunware. All rights reserved.
//

#import "SnakkScreenHelper.h"

@implementation SnakkScreenHelper

+(CGFloat)iOSTabBarOffset{
    return (NSFoundationVersionNumber > NSFoundationVersionNumber_iOS_6_1) ? 0 : 25;
}

@end
