//
//  AppSocketMessageManager.m
//  EMESHT
//
//  Created by appeme on 14-12-10.
//  Copyright (c) 2014年 eme. All rights reserved.
//

#import "AppSocketMessageManager.h"
#import "GCDAsyncSocket.h"
#import "EMEConfigManager.h"
#import "AppCacheManager.h"

#define AppSocketHead 7
#define AppSocketData 8

@interface AppSocketMessageManager ()
@property (strong, nonatomic) GCDAsyncSocket *asyncSocket;
@property (strong, nonatomic) dispatch_queue_t socketQueue;
@property (copy, nonatomic) NSString *host;
@property (assign, nonatomic) unsigned short port;

@property (strong, nonatomic) NSMutableData *messageBodyData;
@property (assign, nonatomic) int messageBodyRemainLength;
@end

@implementation AppSocketMessageManager
- (instancetype)initHost:(NSString *)host andPort:(unsigned short)port {
    if (self = [super init]) {
        _host = host;
        _port = port;

        [self startSocket];
    }
    return self;
}

- (void)startSocket {
    self.socketQueue = dispatch_queue_create("emeapp socket queue", DISPATCH_QUEUE_SERIAL);
    _asyncSocket = [[GCDAsyncSocket alloc] initWithDelegate:self delegateQueue:dispatch_get_main_queue()];

    NSError *error = nil;
    if (![_asyncSocket connectToHost:self.host onPort:self.port error:&error]) {
        NSLog_d(@"Unable to connect to due to invalid configuration: %@", error);
    } else {
        NSLog_d(@"Connecting to \"%@\" on port %hu...", self.host, self.port);
    }

    // Use socket:didReceiveTrust:completionHandler: delegate method for manual trust evaluation
    //    NSDictionary *options = @{
    //        GCDAsyncSocketManuallyEvaluateTrust : @(YES),
    //        GCDAsyncSocketSSLPeerName : self.host
    //    };
    //    NSLog_d(@"Requesting StartTLS with options:\n%@", options);
    //    [_asyncSocket startTLS:options];
}

- (void)socket:(GCDAsyncSocket *)sock didConnectToHost:(NSString *)host port:(UInt16)port {
    NSLog_d(@"socket:didConnectToHost:%@ port:%hu", host, port);

    RegistorSocketRequest *registorSocketRequest = [RegistorSocketRequest createRegisterSocketRequest];
    NSString *jsonString = [registorSocketRequest toJSONString];
    NSData *jsonData = [jsonString dataUsingEncoding:NSASCIIStringEncoding];

    int packageLen = jsonData.length + 2;
    Byte head[6] = {0};
    [AppSocketMessageManager intToByte:head offert:0 intValue:packageLen];
    NSData *headData = [[NSData alloc] initWithBytes:head length:sizeof(head)];
    [_asyncSocket writeData:headData withTimeout:-1 tag:AppSocketHead];
    [_asyncSocket writeData:jsonData withTimeout:-1 tag:AppSocketHead];

    [_asyncSocket readDataWithTimeout:-1 buffer:nil bufferOffset:0 maxLength:4 tag:AppSocketHead];
}

- (void)socket:(GCDAsyncSocket *)sock didReceiveTrust:(SecTrustRef)trust completionHandler:(void (^)(BOOL shouldTrustPeer))completionHandler {
    NSLog_d(@"socket:shouldTrustPeer:");

    dispatch_queue_t bgQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(bgQueue, ^{
        // This is where you would (eventually) invoke SecTrustEvaluate.
        // Presumably, if you're using manual trust evaluation, you're likely doing extra stuff here.
        // For example, allowing a specific self-signed certificate that is known to the app.
        
        SecTrustResultType result = kSecTrustResultDeny;
        OSStatus status = SecTrustEvaluate(trust, &result);
        
        if (status == noErr && (result == kSecTrustResultProceed || result == kSecTrustResultUnspecified)) {
            completionHandler(YES);
        }
        else {
            completionHandler(NO);
        }
    });
}

- (void)socketDidSecure:(GCDAsyncSocket *)sock {
}

- (void)socket:(GCDAsyncSocket *)sock didWriteDataWithTag:(long)tag {
}

- (void)socket:(GCDAsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag {
    if (tag == AppSocketHead) {
        Byte head[4] = {0};
        [data getBytes:head length:sizeof(head)];
        self.messageBodyRemainLength = [AppSocketMessageManager bytesToInt:head offert:0];
        [_asyncSocket readDataWithTimeout:-1 buffer:nil bufferOffset:0 maxLength:self.messageBodyRemainLength tag:AppSocketData];
    } else if (tag == AppSocketData) {
        if (self.messageBodyData == nil) {
            self.messageBodyData = [[NSMutableData alloc] init];
        }

        [self.messageBodyData appendData:data];
        self.messageBodyRemainLength -= data.length;

        if (self.messageBodyRemainLength != 0) {
            [_asyncSocket readDataWithTimeout:-1 buffer:nil bufferOffset:0 maxLength:self.messageBodyRemainLength tag:AppSocketData];
            return;
        }

        Byte head[2] = {0};
        [data getBytes:head length:2];

        NSData *subData = [self.messageBodyData subdataWithRange:NSMakeRange(2, self.messageBodyData.length - 2)];
        NSString *jsonString = [[NSString alloc] initWithData:subData encoding:NSUTF8StringEncoding];

        if (self.delegate) {
            self.messageBodyData = nil;
            [self.delegate receivedAppSocketMessage:jsonString];
        }

        [_asyncSocket readDataWithTimeout:-1 buffer:nil bufferOffset:0 maxLength:4 tag:AppSocketHead];
    }
}

- (void)closeSocket {
    _asyncSocket.delegate = nil;
    [_asyncSocket disconnect];
}

- (void)socketDidDisconnect:(GCDAsyncSocket *)sock withError:(NSError *)err {
    NSLog_d(@"socketDidDisconnect:withError: \"%@\"", err);

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self startSocket];
    });
}

+ (void)intToByte:(Byte[])bytes offert:(int)offset intValue:(int)value {
    bytes[0] = (Byte)((value & 0xFF000000) >> 24);
    bytes[1] = (Byte)((value & 0x00FF0000) >> 16);
    bytes[2] = (Byte)((value & 0x0000FF00) >> 8);
    bytes[3] = (Byte)((value & 0x000000FF));
}

+ (int)bytesToInt:(Byte[])bytes offert:(int)offset {
    int value;
    value = (int)((bytes[offset + 3] & 0xFF) | ((bytes[offset + 2] << 8) & 0xFF00) | ((bytes[offset + 1] << 16) & 0xFF0000) | ((bytes[offset] << 24) & 0xFF000000));
    return value;
}
@end

@implementation RegistorSocketData
@end

@implementation RegistorSocketRequest
+ (RegistorSocketRequest *)createRegisterSocketRequest {
    RegistorSocketData *data = [[RegistorSocketData alloc] init];
    data.uId = [AppCacheManager sharedManager].loginUser.id;

    RegistorSocketRequest *registorSocketRequest = [[RegistorSocketRequest alloc] init];
    registorSocketRequest.module = @"socket";
    registorSocketRequest.api = @"registor";
    registorSocketRequest.apiver = @"v1";//[[EMEConfigManager shareConfigManager] getAppFileVersion];
    registorSocketRequest.appcode = [[EMEConfigManager shareConfigManager] getAppCode];
    registorSocketRequest.userid = [AppCacheManager sharedManager].loginUser.id;
    registorSocketRequest.token = @"1";
    registorSocketRequest.data = data;

    return registorSocketRequest;
}
@end