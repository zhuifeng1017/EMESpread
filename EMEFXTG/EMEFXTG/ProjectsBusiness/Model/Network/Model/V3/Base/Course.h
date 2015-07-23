//
//  Course.h
//  EMEZL
//
//  Created by apple on 15/4/29.
//  Copyright (c) 2015年 appeme. All rights reserved.
//

#import "LooseJSONModel.h"

@interface Course : LooseJSONModel
@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, strong) User *creator;
@property (nonatomic, copy) NSString *createTime;
@property (nonatomic, copy) NSString *channel;
@property (nonatomic, copy) NSString *refId;
@end

#pragma mark - request
@interface QueryCourseRequest : LooseJSONModel
@property (nonatomic, copy) NSString *uId;
@end
