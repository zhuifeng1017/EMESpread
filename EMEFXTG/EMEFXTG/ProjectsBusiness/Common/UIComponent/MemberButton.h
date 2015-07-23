//
//  MemberButton.h
//  EMESHT
//
//  Created by xuanhr on 15/3/10.
//  Copyright (c) 2015年 eme. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    MemberButtonTypeNormal = 0,   // 正常状态
    MemberButtonTypeDelete = 1,   // 删除按钮
    MemberButtonTypeCheck = 2, // 成员按钮选择框
} MemberButtonType;

typedef void (^ChooseMemberButtonBlock)(void);

@interface MemberButton : UIButton
@property (nonatomic, strong) UIButton *deleteBtn;
@property (nonatomic, strong) UIImageView *isAdmin;

@property (assign, nonatomic) MemberButtonType *type;
@end
