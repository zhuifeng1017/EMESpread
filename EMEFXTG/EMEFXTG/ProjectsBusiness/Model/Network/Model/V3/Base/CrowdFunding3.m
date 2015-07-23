//
//  CrowdFunding3.m
//  EMESHT
//
//  Created by apple on 15/5/7.
//  Copyright (c) 2015年 eme. All rights reserved.
//

#import "CrowdFunding3.h"

@implementation BaseCrowdFunding3
@end

@implementation CrowdFunding3Genre
@end

@implementation CrowdFunding3Project

@end

@implementation CrowdFunding3Invest

@end

@implementation CrowdFunding3
@end

@implementation CrowdFunding3Response

@end

@implementation QueryCrowdFunding3GenreRequest

- (NSString *)requestMethod {
    return @"fudgenre/query";
}

@end

@implementation QueryCrowdFunding3CategoryRequest

- (NSString *)requestMethod {
    return @"fudcategory/query";
}

@end

@implementation QueryCrowdFunding3Request
- (NSString *)requestMethod {
    return @"fudproject/query";
}
@end

@implementation SaveCrowdFunding3Request
- (NSString *)requestMethod {
    return @"fudapply/save";
}

@end

@implementation DelCrowdFunding3Request
- (NSString *)requestMethod {
    return @"fudapply/delete";
}
@end

@implementation DelCrowdFunding3Response

@end

@implementation UpdateCrowdFunding3Request

- (NSString *)requestMethod {
    return @"fudapply/update";
}

@end

@implementation PayCrowdFunding3Request

- (NSString *)requestMethod {
    return @"fudproject/pay";
}

@end

@implementation MyFudApplyRequest
- (NSString *)requestMethod {
    return @"fudapply/my";
}

@end

@implementation MyFudApplyResponse

@end

@implementation MyPayCrowdFunding3Request

- (NSString *)requestMethod {
    return @"fudproject/mypay";
}

@end

@implementation AskCrowdFunding3Request

- (NSString *)requestMethod {
    return @"fudproject/ask";
}

@end

@implementation AskCrowdFunding3Response

@end

@implementation PraiseCrowdFunding3Request

- (NSString *)requestMethod {
    return @"fudproject/praise";
}

@end

@implementation StarCrowdFunding3Request

- (NSString *)requestMethod {
    return @"fudproject/history";
}
@end

@implementation GetCrowdFunding3Request

- (NSString *)requestMethod {
    return @"fudproject/get";
}

@end

@implementation MyStaredCrowdFunding3Request

- (NSString *)requestMethod {
    return @"fudproject/myhistory";
}

@end

@implementation QueryPayCrowdFunding3Request

- (NSString *)requestMethod {
    return @"fudproject/queryPay";
}

@end

@implementation AuditCrowdFunding3Request

- (NSString *)requestMethod {
    return @"fudapply/audit";
}

@end

@implementation SaveCrowdFunding3CommentRequest
- (NSString *)requestMethod {
    return @"fudproject/comment";
}
@end
