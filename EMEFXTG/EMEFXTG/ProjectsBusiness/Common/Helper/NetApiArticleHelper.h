//
//  ArticleHelper.h
//  EMESHT
//
//  Created by appeme on 14-12-2.
//  Copyright (c) 2014年 eme. All rights reserved.
//

#import <Foundation/Foundation.h>
#include "Article.h"

typedef void (^GetArticleBlock)(NSString *message, Article *article);
typedef void (^QueryArticleBlock)(NSString *message, NSArray *articles);
typedef void (^DeleteArticleBlock)(NSString *message);
typedef void (^ShareArticleBlock)(NSString *message);
typedef void (^CommentBlock)(NSString *message, Comment *comment);
typedef void (^GetCommentBlock)(NSString *message, NSArray *comments);

@interface NetApiArticleHelper : NSObject
+ (void)saveArticle:(SaveArticleRequest *)request withBlock:(GetArticleBlock)block;
+ (void)updateArticle:(UpdateArticleRequest *)request withBlock:(GetArticleBlock)block;
+ (void)queryArticle:(NSString *)socialGroupId withBlock:(QueryArticleBlock)block;
+ (void)getArticle:(NSString *)articleId withBlock:(GetArticleBlock)block;
+ (void)deleteArticle:(NSArray *)articleIds withBlock:(DeleteArticleBlock)block;
+ (void)shareArticle:(NSString *)articleId toUsers:(NSArray *)uIds withBlock:(ShareArticleBlock)block;
+ (void)saveComment:(NSString *)comment forArticleId:(NSString *)articleId withBlock:(CommentBlock)block;
+ (void)getCommentByArticleId:(NSString *)articleId withBlock:(GetCommentBlock)block;
+ (void)savePraise:(NSString *)articleId byUserId:(NSString *)userId withBlock:(GetArticleBlock)block;
@end
