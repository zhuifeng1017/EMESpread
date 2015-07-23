//
//  EMEHttpBatchRequest.h
//  EMESHT
//
//  Created by appeme on 15/2/10.
//  Copyright (c) 2015年 eme. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EMEHttpBatchRequest : EMEHttpRequest
@property (strong, nonatomic) NSMutableArray *batchResponse;
- (void)sendRequest:(LooseJSONModel *)request response:(Class)responseClass loadingTip:(BOOL)loadingTip autoHideLoadingTipAfterCompletion:(BOOL)autoHide errorTip:(BOOL)errorTip;
- (void)setBatchCompletionBlock:(EMEHttpRequestCompletionBlock)aCompletionBlock;
@end
