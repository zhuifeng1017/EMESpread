//
//  AFOSCClient.m
//  oschina
//
//  Created by wangjun on 12-8-14.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//
#import "AFOSCClient.h"
#import "AFHTTPRequestOperation.h"
#import "AFXMLRequestOperation.h"
#import "AFJSONRequestOperation.h"
#import "AFNetworkActivityIndicatorManager.h"
#import "EMEConfigManager.h"

@interface AFOSCClient ()

@end

@implementation AFOSCClient

+ (AFOSCClient *)sharedClient {
    static AFOSCClient *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSString *baseURLString = [NSString stringWithFormat:@"%@/%@/%@", [[EMEConfigManager shareConfigManager] getAppUrl], [[EMEConfigManager shareConfigManager] getAppFileVersion], [[EMEConfigManager shareConfigManager] getAppService]];
        
        _sharedClient = [[AFOSCClient alloc] initWithBaseURL:[NSURL URLWithString:baseURLString]];
        [_sharedClient setDefaultHeader:@"User-Agent"
                                  value:[NSString stringWithFormat:@"%@/%@",
                                         [[EMEConfigManager shareConfigManager] getAppService],
                                        [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]
                                         ]];
        // 状态栏显示网络活动指示器
        [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
    });

    return _sharedClient;
}

- (id)initWithBaseURL:(NSURL *)url {
    self = [super initWithBaseURL:url];
    if (!self) {
        return nil;
    }

    [self registerHTTPOperationClass:[AFJSONRequestOperation class]];
    [AFJSONRequestOperation addAcceptableContentTypes:[NSSet setWithObject:@"text/html"]];
    // Accept HTTP Header; see http://www.w3.org/Protocols/rfc2616/rfc2616-sec14.html#sec14.1
    [self setDefaultHeader:@"Accept" value:@"application/json"];
    self.allowsInvalidSSLCertificate = YES;
    return self;
}

@end
