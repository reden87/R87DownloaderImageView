//
//  R87ImageView.h
//  R87ImageView
//
//  Created by Gergő Németh on 04/04/15.
//  Copyright (c) 2015 reden87. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface R87ImageView : UIImageView

#pragma mark - Properties

/** Optional activity indicator view.
 
 If you don't set this property then a grey UIActivityIndicatorView will appear */
@property (strong, nonatomic) UIView *activityIndicator;

/** This image will be displayed if an error occures while downloading image. */
@property (strong, nonatomic) UIImage *errorImage;

#pragma mark - Methods

/** This method will download an image from the specified link and displays it.
 
 While the download is in progress an activityIndicator view is displayed.
 
 If the image property is set then this function returns and does nothing.
 */
- (void)downloadImageWithLink:(NSString *)imageLink
			 withSuccessBlock:(void(^)(NSData *imageData))successBlock
				 failureBlock:(void(^)(NSError *error))failureBlock;

@end
