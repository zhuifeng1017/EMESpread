//
//  AddressBookInfo.h
//  EMESHT
//
//  Created by appeme on 14-11-20.
//  Copyright (c) 2014年 eme. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AddressBookInfo : NSObject
@property (nonatomic, copy) NSString *id;              //用户编号
@property (nonatomic, copy) NSString *mobile;          //电话
@property (nonatomic, copy) NSString *pinyin;          //拼音
@property (nonatomic, copy) NSString *pinyinIndexChar; //拼音索引
@property (nonatomic, copy) NSString *sex;             //性别(0:男,1:女)
@property (nonatomic, copy) NSString *name;            //姓名
@property (nonatomic, copy) NSString *icon;            //用户图像
@end
