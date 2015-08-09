//
//  R87DownloaderImageView.h
//  R87DownloaderImageView
//
//  Created by Gergő Németh on 04/04/15.
//  Copyright (c) 2015 reden87. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/**
 <code>R87DownloaderImageView</code> is a <code>UIImageView</code> subclass which makes possible to download an image from the provided link.
 
 While the download is in progress the default or a custom propgress bar is displayed, the download returns a success block with the downloaded image or a failure block in case of an error.
 */
@interface R87DownloaderImageView : UIImageView

#pragma mark - Properties
/// ----------------
/// @name Properties
/// ----------------

/**
 Optional activity indicator view.
 
 If you set a custom UIView then that view will be displayed while the image is being downloaded.
 
 @note If you don't set this property then a <code>UIActivityIndicatorViewStyleGray</code> type <code>UIActivityIndicatorView</code> will appear.
*/
@property (strong, nonatomic) UIView *activityIndicator;

/**
 This <code>UIImageView</code> will be displayed if an error occures while downloading the image.
 */
@property (strong, nonatomic) UIImage *errorImage;

#pragma mark - Methods
/// -------------
/// @name Methods
/// -------------

/**
 This method will download an image from the specified link and displays it.
 
 While the download is in progress the <code>activityIndicator</code> property is displayed.
 
 @warning If the <code>image</code> property is set in the instance then this function returns the success block with nil parameter!
 
 @param imageLink		The link of the image file (as an <code>NSString</code class>
 @param successBlock	This block will return in case of successfule image download. The result <code>imageData</code> parameter will contain the image as an <code>NSData</code> object.
 @param failureBlock	This block will return in case of unsuccessful image download. The result <code>error</code> parameter will contain the error as an <code>NSError</code> object.
 */
- (void)downloadImageWithLink:(NSString *)imageLink
			 withSuccessBlock:(void(^)(NSData *imageData))successBlock
				 failureBlock:(void(^)(NSError *error))failureBlock;

@end
