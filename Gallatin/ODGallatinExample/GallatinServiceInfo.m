//
//  GallatinServiceInfo.m
//  ODGallatinExample
//
//  Created by Kevin Lam on 7/7/16.
//  Copyright © 2016 OneDrive. All rights reserved.
//

#import "GallatinServiceInfo.h"
#import <OneDriveSDK/ODServiceInfo+Protected.h>

@implementation GallatinServiceInfo

- (instancetype)initWithClientId:(NSString *)clientId
                      capability:(NSString *)capability
                      resourceId:(NSString *)resourceId
                     apiEndpoint:(NSString *)apiEndpoint
                     redirectURL:(NSString *)redirectURL
                           flags:(NSDictionary *)flags
{
    NSParameterAssert(redirectURL);
    NSParameterAssert(apiEndpoint || [OD_DISCOVERY_SERVICE_URL containsString:resourceId]);
    
    self = [super initWithClientId:clientId scopes:nil flags:flags];
    if (self){
        _capability = capability;
        _redirectURL = redirectURL;
        _resourceId = resourceId;
        _apiEndpoint = apiEndpoint;
        _authorityURL = @"https://login.chinacloudapi.cn/common/oauth2/token";
        _discoveryServiceURL = nil;
    }
    return self;
}

@end
