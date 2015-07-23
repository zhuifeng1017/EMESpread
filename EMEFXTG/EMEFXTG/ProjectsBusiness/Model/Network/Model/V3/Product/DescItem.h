//
//  DescItem.h
//  EMEHS-MGT
//
//  Created by xuanhr on 14-9-9.
//  Copyright (c) 2014年 appeme. All rights reserved.
//

#import "LooseJSONModel.h"
@protocol DescItem <NSObject>
@end

@interface DescItem : LooseJSONModel
@property (nonatomic, copy) NSString *url;  //商品描述资源地址
@property (nonatomic, copy) NSString *desc; //商品介绍文字

@end
