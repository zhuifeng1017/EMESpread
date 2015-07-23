//
//  Product.h
//  EMEFXTG
//
//  Created by appeme on 15/7/21.
//  Copyright (c) 2015年 eme. All rights reserved.
//

#import "LooseJSONModel.h"

@interface Product : LooseJSONModel
@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *createTime;
@property (nonatomic, copy) NSNumber *createTimeL;
@property (nonatomic, copy) NSNumber *type;
@property (nonatomic, copy) WXLoginRequest *authorInfo;
@end

#pragma mark - Reqeuest
@interface FindProductRequest : LooseJSONModel
@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *uId;
@property (nonatomic, copy) NSString *title;
@end
