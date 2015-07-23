/*
 * This file is part of the SDWebImage package.
 * (c) Olivier Poitrey <rs@dailymotion.com>
 *
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

#import "SDWebImageCompatOld.h"

@class SDWebImageDownloaderOld;

/**
 * Delegate protocol for SDWebImageDownloaderOld
 */
@protocol SDWebImageDownloaderDelegateOld <NSObject>

@optional

- (void)imageDownloaderDidFinish:(SDWebImageDownloaderOld *)downloader;

/**
 * Called repeatedly while the image is downloading when [SDWebImageDownloaderOld progressive] is enabled.
 *
 * @param downloader The SDWebImageDownloaderOld instance
 * @param image The partial image representing the currently download portion of the image
 */
- (void)imageDownloader:(SDWebImageDownloaderOld *)downloader didUpdatePartialImage:(UIImage *)image;

/**
 * Called when download completed successfuly.
 *
 * @param downloader The SDWebImageDownloaderOld instance
 * @param image The downloaded image object
 */
- (void)imageDownloader:(SDWebImageDownloaderOld *)downloader didFinishWithImage:(UIImage *)image;

/**
 * Called when an error occurred
 *
 * @param downloader The SDWebImageDownloaderOld instance
 * @param error The error details
 */
- (void)imageDownloader:(SDWebImageDownloaderOld *)downloader didFailWithError:(NSError *)error;

@end
