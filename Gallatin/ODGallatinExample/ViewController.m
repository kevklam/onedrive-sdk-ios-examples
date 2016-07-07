//
//  ViewController.m
//  ODGallatinExample
//
//  Created by Kevin Lam on 7/7/16.
//  Copyright © 2016 OneDrive. All rights reserved.
//

#import "ViewController.h"

#import <OneDriveSDK/OneDriveSDK.h>
#import <OneDriveSDK/ODBusinessAuthProvider.h>

#import "GallatinServiceInfo.h"

@interface ViewController ()

@property (nonatomic, strong) ODClient *client;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    GallatinServiceInfo *serviceInfo = [[GallatinServiceInfo alloc] initWithClientId:@"f8af1a12-68e3-42b7-9660-07989c93130c"
                                                                    capability:@"MyFiles"
                                                                    resourceId:@"https://cjledu-my.sharepoint.cn/"
                                                                   apiEndpoint:@"https://cjledu-my.sharepoint.cn/_api/v2.0"
                                                                   redirectURL:@"http://60.28.182.24:9080/appApi/OnCallBack"
                                                                         flags:nil];
    
    ODBusinessAuthProvider *authProvider = [[ODBusinessAuthProvider alloc]
                                                initWithServiceInfo:serviceInfo
                                                       httpProvider:[ODAppConfiguration defaultConfiguration].httpProvider
                                                       accountStore:[ODAppConfiguration defaultConfiguration].accountStore
                                                             logger:[ODAppConfiguration defaultConfiguration].logger];
    
    [ODClient setAuthProvider:authProvider];
    
    // Add this line because of wrong NSParameterAssert in SDK
    [ODAppConfiguration defaultConfiguration].microsoftAccountAppId = @"temp-hack-dummy";
    
    [ODClient clientWithCompletion:^(ODClient *client, NSError *error) {
        if (!error) {
            NSLog(@"Logged in!");
            self.client = client;
            
            [self makeSomeRequest];
        }
        else {
            NSLog(@"Error logging in!");
        }
    }];
}

- (void)makeSomeRequest {
    [[[[[self.client drive] items:@"root"] children] request] getWithCompletion:^(ODCollection *response, ODChildrenCollectionRequest *nextRequest, NSError *error)
     {
        if (!error) {
            for (ODItem *item in response.value) {
                NSLog(@"File name: %@", item.name);
            }
        }
        else {
            NSLog(@"Error getting children!");
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
