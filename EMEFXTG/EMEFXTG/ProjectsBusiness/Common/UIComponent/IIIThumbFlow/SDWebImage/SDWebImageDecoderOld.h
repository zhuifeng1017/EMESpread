/*
 * This file is part of the SDWebImage package.
 * (c) Olivier Poitrey <rs@dailymotion.com>
 *
 * Created by james <https://github.com/mystcolor> on 9/28/11.
 *
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

#import <Foundation/Foundation.h>
#import "SDWebImageCompatOld.h"

@protocol SDWebImageDecoderDelegate;

/**
 * Decoding image data is the most expensive step, and it is performed on the main thread. SDWebImageDecoderOld force the
 * image decoding in a separate thread so UIImage will have high chance to reuse the cached result when used by UI in
 * the main thread.
 *
 * @see https://github.com/rs/SDWebImage/pull/18
 */

@interface SDWebImageDecoderOld : NSObject {
    NSOperationQueue *imageDecodingQueue;
}

/**
 * Returns a shared global instance of image decoder
 *
 * @return An SDWebImageDecoderOld shared instance
 */
+ (SDWebImageDecoderOld *)sharedImageDecoder;

/**
 * Pre-decode a given image in a separate thread.
 *
 * @param image The image to pre-decode
 * @param delegate The object to notify once pre-decoding is completed
 * @param info A user info object
 */
- (void)decodeImage:(UIImage *)image withDelegate:(id<SDWebImageDecoderDelegate>)delegate userInfo:(NSDictionary *)info;

@end

/**
 * Delegate protocol for SDWebImageDecoderOld
 */
@protocol SDWebImageDecoderDelegate <NSObject>

/**
 * Called when pre-decoding is completed
 *
 * @param decoder The image decoder instance
 * @param image The pre-decoded image
 * @param userInfo the provided user info dictionary
 */
- (void)imageDecoder:(SDWebImageDecoderOld *)decoder didFinishDecodingImage:(UIImage *)image userInfo:(NSDictionary *)userInfo;

@end

@interface UIImage (ForceDecode)

+ (UIImage *)decodedImageWithImage:(UIImage *)image;

@end
