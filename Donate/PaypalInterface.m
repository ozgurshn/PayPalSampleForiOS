//
//  ZZAppDelegate.m
//  PayPal-iOS-SDK-Sample-App
//
//  Copyright (c) 2014, PayPal
//  All rights reserved.
//

#import "PaypalInterface.h"
#import "PayPalMobile.h"

@implementation PaypalInterface


-(void)initPaypal
{
    [PayPalMobile initializeWithClientIdsForEnvironments:@{PayPalEnvironmentProduction : @"YOUR_CLIENT_ID_FOR_PRODUCTION",
                                                           PayPalEnvironmentSandbox : @"AbawWOa0G-aY6CWRsVNrtndgQ4AfpyfF9nTk1LvzK1VCPNVcI-rvErHIu8gaAlkZ4MpW5P7Hx1ZnJz_g"}];
}
@end
