/*
 * This file is part of the SDWebImage package.
 * (c) Olivier Poitrey <rs@dailymotion.com>
 *
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

#import "SDWebImageCompatOld.h"
#import "SDWebImageDownloaderDelegateOld.h"
#import "SDWebImageManagerDelegateOld.h"
#import "SDImageCacheDelegate.h"

typedef enum {
    SDWebImageRetryFailed = 1 << 0,
    SDWebImageLowPriority = 1 << 1,
    SDWebImageCacheMemoryOnly = 1 << 2,
    SDWebImageProgressiveDownload = 1 << 3
} SDWebImageOptions;

#if NS_BLOCKS_AVAILABLE
typedef void (^SDWebImageSuccessBlock)(UIImage *image, BOOL cached);
typedef void (^SDWebImageFailureBlock)(NSError *error);
#endif

/**
 * The SDWebImageManagerOld is the class behind the UIImageView+WebCache category and likes.
 * It ties the asynchronous downloader (SDWebImageDownloaderOld) with the image cache store (SDImageCacheOld).
 * You can use this class directly to benefit from web image downloading with caching in another context than
 * a UIView.
 *
 * Here is a simple example of how to use SDWebImageManagerOld:
 *
 *  SDWebImageManagerOld *manager = [SDWebImageManagerOld sharedManager];
 *  [manager downloadWithURL:imageURL
 *                  delegate:self
 *                   options:0
 *                   success:^(UIImage *image, BOOL cached)
 *                   {
 *                       // do something with image
 *                   }
 *                   failure:nil];
 */
@interface SDWebImageManagerOld : NSObject <SDWebImageDownloaderDelegateOld, SDImageCacheDelegate> {
    NSMutableArray *downloadInfo;
    NSMutableArray *downloadDelegates;
    NSMutableArray *downloaders;
    NSMutableArray *cacheDelegates;
    NSMutableArray *cacheURLs;
    NSMutableDictionary *downloaderForURL;
    NSMutableArray *failedURLs;
}

#if NS_BLOCKS_AVAILABLE
typedef NSString * (^CacheKeyFilter)(NSURL *url);

/**
 * The cache filter is a block used each time SDWebManager need to convert an URL into a cache key. This can
 * be used to remove dynamic part of an image URL.
 *
 * The following example sets a filter in the application delegate that will remove any query-string from the
 * URL before to use it as a cache key:
 *
 * 	[[SDWebImageManagerOld sharedManager] setCacheKeyFilter:^(NSURL *url)
 *	{
 *	    url = [[NSURL alloc] initWithScheme:url.scheme host:url.host path:url.path];
 *	    return [url absoluteString];
 *	}];
 */
@property (strong) CacheKeyFilter cacheKeyFilter;
#endif

/**
 * Returns global SDWebImageManagerOld instance.
 *
 * @return SDWebImageManagerOld shared instance
 */
+ (id)sharedManager;

- (UIImage *)imageWithURL:(NSURL *)url __attribute__((deprecated));

/**
 * Downloads the image at the given URL if not present in cache or return the cached version otherwise.
 *
 * @param url The URL to the image
 * @param delegate The delegate object used to send result back
 * @see [SDWebImageManagerOld downloadWithURL:delegate:options:userInfo:]
 * @see [SDWebImageManagerOld downloadWithURL:delegate:options:userInfo:success:failure:]
 */
- (void)downloadWithURL:(NSURL *)url delegate:(id<SDWebImageManagerDelegateOld>)delegate;

/**
 * Downloads the image at the given URL if not present in cache or return the cached version otherwise.
 *
 * @param url The URL to the image
 * @param delegate The delegate object used to send result back
 * @param options A mask to specify options to use for this request
 * @see [SDWebImageManagerOld downloadWithURL:delegate:options:userInfo:]
 * @see [SDWebImageManagerOld downloadWithURL:delegate:options:userInfo:success:failure:]
 */
- (void)downloadWithURL:(NSURL *)url delegate:(id<SDWebImageManagerDelegateOld>)delegate options:(SDWebImageOptions)options;

/**
 * Downloads the image at the given URL if not present in cache or return the cached version otherwise.
 *
 * @param url The URL to the image
 * @param delegate The delegate object used to send result back
 * @param options A mask to specify options to use for this request
 * @param info An NSDictionnary passed back to delegate if provided
 * @see [SDWebImageManagerOld downloadWithURL:delegate:options:success:failure:]
 */
- (void)downloadWithURL:(NSURL *)url delegate:(id<SDWebImageManagerDelegateOld>)delegate options:(SDWebImageOptions)options userInfo:(NSDictionary *)info;

// use options:SDWebImageRetryFailed instead
- (void)downloadWithURL:(NSURL *)url delegate:(id<SDWebImageManagerDelegateOld>)delegate retryFailed:(BOOL)retryFailed __attribute__((deprecated));
// use options:SDWebImageRetryFailed|SDWebImageLowPriority instead
- (void)downloadWithURL:(NSURL *)url delegate:(id<SDWebImageManagerDelegateOld>)delegate retryFailed:(BOOL)retryFailed lowPriority:(BOOL)lowPriority __attribute__((deprecated));

#if NS_BLOCKS_AVAILABLE
/**
 * Downloads the image at the given URL if not present in cache or return the cached version otherwise.
 *
 * @param url The URL to the image
 * @param delegate The delegate object used to send result back
 * @param options A mask to specify options to use for this request
 * @param success A block called when image has been retrived successfuly
 * @param failure A block called when couldn't be retrived for some reason
 * @see [SDWebImageManagerOld downloadWithURL:delegate:options:]
 */
- (void)downloadWithURL:(NSURL *)url delegate:(id)delegate options:(SDWebImageOptions)options success:(SDWebImageSuccessBlock)success failure:(SDWebImageFailureBlock)failure;

/**
 * Downloads the image at the given URL if not present in cache or return the cached version otherwise.
 *
 * @param url The URL to the image
 * @param delegate The delegate object used to send result back
 * @param options A mask to specify options to use for this request
 * @param info An NSDictionnary passed back to delegate if provided
 * @param success A block called when image has been retrived successfuly
 * @param failure A block called when couldn't be retrived for some reason
 * @see [SDWebImageManagerOld downloadWithURL:delegate:options:]
 */
- (void)downloadWithURL:(NSURL *)url delegate:(id)delegate options:(SDWebImageOptions)options userInfo:(NSDictionary *)info success:(SDWebImageSuccessBlock)success failure:(SDWebImageFailureBlock)failure;
#endif

/**
 * Cancel all pending download requests for a given delegate
 *
 * @param delegate The delegate to cancel requests for
 */
- (void)cancelForDelegate:(id<SDWebImageManagerDelegateOld>)delegate;

/**
 * Cancel all current opreations
 */
- (void)cancelAll;

@end
