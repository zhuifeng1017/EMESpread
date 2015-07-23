//
//  AppSocketMessageManager.h
//  EMESHT
//
//  Created by appeme on 14-12-10.
//  Copyright (c) 2014年 eme. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol AppSocketMessageDelegate
- (void)receivedAppSocketMessage:(NSString *)jsonMessage;
@end

@interface AppSocketMessageManager : NSObject
@property (weak, nonatomic) id<AppSocketMessageDelegate> delegate;
- (instancetype)initHost:(NSString *)host andPort:(unsigned short)port;
- (void)closeSocket;
@end

#pragma mark - socket protocol
@interface RegistorSocketData : LooseJSONModel
@property (nonatomic, copy) NSString *uId; //用户编号
@end

@interface RegistorSocketRequest : LooseJSONModel
@property (nonatomic, copy) NSString *module;  //socket
@property (nonatomic, copy) NSString *api;     //registor
@property (nonatomic, copy) NSString *apiver;  //v1
@property (nonatomic, copy) NSString *appcode; //sht
@property (nonatomic, copy) NSString *userid;  //用户编号
@property (nonatomic, copy) NSString *token;   //token
@property (nonatomic, strong) RegistorSocketData *data;
+ (RegistorSocketRequest *)createRegisterSocketRequest;
@end
