//
//  NetApiHelper.m
//  EMESHT
//
//  Created by appeme on 15/3/12.
//  Copyright (c) 2015年 eme. All rights reserved.
//

#import "NetApiHelper.h"
#import "SVPullToRefresh.h"

@implementation NetApiHelper

+ (void)sendRequest:(LooseJSONModel *)request forResponse:(Class)clazz loadingTip:(BOOL)loadingTip errorTip:(BOOL)errorTip successTip:(NSString *)successTip withBlock:(NetApiBlock)block {
    NetApiBlock blk = [block copy];

    EMEHttpRequest *emeHttpRequest = [[EMEHttpRequest alloc] initWithRequest:request];
    __weak EMEHttpRequest *weakEmeHttpRequest = emeHttpRequest;

    [weakEmeHttpRequest setCompletionBlock:^(EMEHttpRequestStatus status, NSError *error, id response, BOOL isMulitSection, BOOL hasNext) {
        if (status == EMEHttpRequestStatusSuccess) {
            if (successTip) {
                [weakEmeHttpRequest setProgressMessage:successTip andHideAfter:1 timeoutBlock:^{
                    blk(@"success", response);
                }];
            }
            else {
                blk(@"success", response);
            }
        }
        else {
            blk(@"fail", nil);
        }
    }];

    [weakEmeHttpRequest sendRequest:clazz loadingTip:loadingTip autoHideLoadingTipAfterCompletion:!successTip errorTip:YES];
}

+ (void)sendRequest:(LooseJSONModel *)request forResponse:(Class)clazz loadingTip:(BOOL)loadingTip errorTip:(BOOL)errorTip successTip:(NSString *)successTip withArrayBlock:(NetApiArrayBlock)block {
    NetApiArrayBlock blk = [block copy];

    EMEHttpRequest *emeHttpRequest = [[EMEHttpRequest alloc] initWithRequest:request];
    __weak EMEHttpRequest *weakEmeHttpRequest = emeHttpRequest;

    [weakEmeHttpRequest setCompletionBlock:^(EMEHttpRequestStatus status, NSError *error, id response, BOOL isMulitSection, BOOL hasNext) {
        if (status == EMEHttpRequestStatusSuccess) {
            if (successTip) {
                [weakEmeHttpRequest setProgressMessage:successTip andHideAfter:1 timeoutBlock:^{
                    blk(@"success", response);
                }];
            }
            else {
                blk(@"success", response);
            }
        }
        else {
            blk(@"fail", nil);
        }
    }];

    [weakEmeHttpRequest sendRequest:clazz loadingTip:loadingTip autoHideLoadingTipAfterCompletion:!successTip errorTip:YES];
}

+ (void)sendInfiniteScrollingRequest:(LooseJSONModel *)request forResponse:(Class)clazz loadingTip:(BOOL)loadingTip errorTip:(BOOL)errorTip successTip:(NSString *)successTip tableView:(UITableView *)tableView tableDatas:(NSMutableArray *)tableDatas target:(id)target moreRequestSelector:(SEL)moreRequestSelector autoTableReload:(BOOL)autoTableReload withArrayBlock:(NetApiArrayBlock)block {

    NSAssert(tableDatas, @"TableDatas must be not nil");
    NSAssert([tableDatas isKindOfClass:[NSMutableArray class]], @"TableDatas must be mutable array");

    request.offset = @(tableDatas.count);

    NetApiArrayBlock blk = [block copy];

    EMEHttpRequest *emeHttpRequest = [[EMEHttpRequest alloc] initWithRequest:request];
    __weak EMEHttpRequest *weakEmeHttpRequest = emeHttpRequest;
    __weak UITableView *weakTableView = tableView;
    __weak NSMutableArray *weakTableDatas = tableDatas;
    __weak id weakTarget = target;

    [weakEmeHttpRequest setCompletionBlock:^(EMEHttpRequestStatus status, NSError *error, id response, BOOL isMulitSection, BOOL hasNext) {
        if (status == EMEHttpRequestStatusSuccess) {
            if (successTip) {
                [weakEmeHttpRequest setProgressMessage:successTip andHideAfter:1 timeoutBlock:^{
                    if (response) {
                        [weakTableDatas addObjectsFromArray:response];
                    }
                    blk(@"success", weakTableDatas);
                    if (autoTableReload) {
                        [weakTableView reloadData];
                    }
                }];
            }
            else {
                if (response) {
                    [weakTableDatas addObjectsFromArray:response];
                }
                blk(@"success", weakTableDatas);
                if (autoTableReload) {
                    [weakTableView reloadData];
                }
            }
        }
        else {
            blk(@"fail", nil);
        }
        
        [weakTableView.infiniteScrollingView stopAnimating];
        
        [weakTableView addInfiniteScrollingWithActionHandler:^{
            #pragma clang diagnostic push
            #pragma clang diagnostic ignored "-Warc-performSelector-leaks"
            [weakTarget performSelector:moreRequestSelector];
            #pragma clang diagnostic pop
        }];
        
        weakTableView.showsInfiniteScrolling = hasNext;
    }];

    [weakEmeHttpRequest sendRequest:clazz loadingTip:loadingTip autoHideLoadingTipAfterCompletion:!successTip errorTip:YES];
}

@end
