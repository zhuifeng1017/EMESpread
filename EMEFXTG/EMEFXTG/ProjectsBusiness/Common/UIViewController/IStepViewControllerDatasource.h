//
//  IStepViewControllerDatasource.h
//  EMEHS-MGT
//
//  Created by appeme on 14-9-15.
//  Copyright (c) 2014年 appeme. All rights reserved.
//

typedef void (^IStepFillDataBlock)(BOOL succ);

@protocol IStepViewControllerDatasource <NSObject>
@optional
- (BOOL)fillData;
- (BOOL)fillData:(IStepFillDataBlock)block;
- (void)prepareData;
- (NSString *)errorMessage;
@end