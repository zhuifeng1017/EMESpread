//
//  EMEReuestConstant.h
//  EMEHS-MGT
//
//  Created by appeme on 14-9-4.
//  Copyright (c) 2014年 appeme. All rights reserved.
//

#ifndef EMEHS_MGT_EMEReuestConstant_h
#define EMEHS_MGT_EMEReuestConstant_h

@protocol QueryRequestMethod <NSObject>
- (NSString *)requestMethod;
@end

#pragma mark - Security
#define SecuritySupplyLogin @"security/supplyLogin"
#define SecurityUserLogin @"security/userLogin"
#define SecuritySysLogin @"security/sysLogin"

#pragma mark - ProductCtg
#define ProductQueryProductCtg @"product/queryProductCtg"
#define ProductSaveProductCtg @"product/saveProductCtg"
#define ProductUpdateProductCtg @"product/updateProductCtg"
#define ProductDeleteProductCtg @"product/deleteProductCtg"

#endif
