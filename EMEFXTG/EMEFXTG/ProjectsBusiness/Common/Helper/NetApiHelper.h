//
//  NetApiHelper.h
//  EMESHT
//
//  Created by appeme on 15/3/12.
//  Copyright (c) 2015年 eme. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NetApiHelper : NSObject
typedef void (^NetApiBlock)(NSString *message, id response);
typedef void (^NetApiArrayBlock)(NSString *message, NSArray *responses);

+ (void)sendRequest:(LooseJSONModel *)request forResponse:(Class)clazz loadingTip:(BOOL)loadingTip errorTip:(BOOL)errorTip successTip:(NSString *)successTip withBlock:(NetApiBlock)block;

+ (void)sendRequest:(LooseJSONModel *)request forResponse:(Class)clazz loadingTip:(BOOL)loadingTip errorTip:(BOOL)errorTip successTip:(NSString *)successTip withArrayBlock:(NetApiArrayBlock)block;

+ (void)sendInfiniteScrollingRequest:(LooseJSONModel *)request forResponse:(Class)clazz loadingTip:(BOOL)loadingTip errorTip:(BOOL)errorTip successTip:(NSString *)successTip tableView:(UITableView *)tableView tableDatas:(NSMutableArray *)tableDatas target:(id)target moreRequestSelector:(SEL)moreRequestSelector autoTableReload:(BOOL)autoTableReload withArrayBlock:(NetApiArrayBlock)block;
@end
