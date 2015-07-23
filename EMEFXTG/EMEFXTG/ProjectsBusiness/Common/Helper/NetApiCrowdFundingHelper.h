//
//  NetApiCrowdFundingHelper.h
//  EMESHT
//
//  Created by xuanhr on 15/1/22.
//  Copyright (c) 2015年 eme. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CrowdFunding.h"
typedef void (^NetApiCrowdFundingBlock)(NSString *message, CrowdFunding *crowdFunding);
typedef void (^NetApiCrowdFundingQueryBlock)(NSString *message, NSArray *crowdFundings);

@interface NetApiCrowdFundingHelper : NSObject
+ (void)saveCrowdFundingRequest:(SaveCrowdFundingRequest *)request withBlock:(NetApiCrowdFundingBlock)block;
+ (void)updateCrowdFundingRequest:(UpdateCrowdFundingRequest *)request withBlock:(NetApiCrowdFundingBlock)block;
+ (void)queryCrowdFundingRequest:(QueryCrowdFundingRequest *)request withBlock:(NetApiCrowdFundingQueryBlock)block;
+ (void)deleteCrowdFundingRequestWithIdArray:(NSArray *)idLst withBlock:(NetApiCrowdFundingQueryBlock)block;

@end
