//
//  Content.h
//  EMEZL
//
//  Created by apple on 15/4/24.
//  Copyright (c) 2015年 appeme. All rights reserved.
//

#import "LooseJSONModel.h"
@protocol Content
@end

@interface Content : LooseJSONModel
@property (nonatomic, copy) NSString *type;  //类型（txt,voice,img）
@property (nonatomic, copy) NSString *value; //信息
@end

@interface SaveContent : LooseJSONModel
@property (nonatomic, copy) NSString *id;//内容ID
@end

#pragma mark - Request
@interface SaveContentRequest : LooseJSONModel
@property (nonatomic, copy) NSString *userId;//用户的ID
@property (nonatomic, copy) NSString *title;//内容标题
@end
