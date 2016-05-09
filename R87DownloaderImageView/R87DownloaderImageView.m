//
//  R87DownloaderImageView.m
//  R87DownloaderImageView
//
//  Created by Gergő Németh on 04/04/15.
//  Copyright (c) 2015 reden87. All rights reserved.
//
//
//  The MIT License (MIT)
//
//  Copyright (c) 2015 reden87
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.
//

#import "R87DownloaderImageView.h"

#define R87CustomErrorDomain @"info.reden87"
#define HTTPErrorCode 1001
#define HTTPErrorMessage NSLocalizedString(@"Server response error!", nil)

@implementation R87DownloaderImageView

#pragma mark Lazy Instantiation

// getters
- (UIView *)activityIndicator {
	if (!_activityIndicator) {
		UIActivityIndicatorViewStyle style;
#if TARGET_OS_IOS
		style = UIActivityIndicatorViewStyleGray;
#else
		style = UIActivityIndicatorViewStyleWhite;
#endif
		UIActivityIndicatorView *activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:style];
		[activityIndicator startAnimating];
		
		_activityIndicator = activityIndicator;
	}
	
	return _activityIndicator;
}

// setters

#pragma mark - Initialization

- (void)downloadImageWithLink:(NSString *)imageLink
			 withSuccessBlock:(void(^)(NSData *imageData))successBlock
				 failureBlock:(void(^)(NSError *error))failureBlock {
	
	// return if image exists
	if (self.image) {
		if (successBlock) successBlock(nil);
		return;
	}
	
	// show UIActivityIndicatorView
	[self addSubview:self.activityIndicator];
	self.activityIndicator.translatesAutoresizingMaskIntoConstraints = NO;
	
	[self addConstraint:[NSLayoutConstraint constraintWithItem:self.activityIndicator
													 attribute:NSLayoutAttributeCenterX
													 relatedBy:NSLayoutRelationEqual
														toItem:self
													 attribute:NSLayoutAttributeCenterX
													multiplier:1.0
													  constant:0.0]];
	[self addConstraint:[NSLayoutConstraint constraintWithItem:self.activityIndicator
													 attribute:NSLayoutAttributeCenterY
													 relatedBy:NSLayoutRelationEqual
														toItem:self
													 attribute:NSLayoutAttributeCenterY
													multiplier:1.0
													  constant:0.0]];
	
	// download image
	NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:imageLink]];
	
	[NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
		
		// remove loading animation
		[self.activityIndicator removeFromSuperview];
		
		// return failure block in case of connection error
		if (connectionError) {
			if (self.errorImage) self.image = self.errorImage;
			
			if (failureBlock) failureBlock(connectionError);
			return;
		}
		
		// return failure block in case of the resonse status code != 200 (OK)
		NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
		if (httpResponse.statusCode != 200) {
			if (self.errorImage) self.image = self.errorImage;
			
			if( failureBlock ) failureBlock([[NSError alloc] initWithDomain:R87CustomErrorDomain code:HTTPErrorCode userInfo:@{NSLocalizedDescriptionKey: HTTPErrorMessage}]);
			return;
		}
		
		// success: show image and call the success block
		self.image = [UIImage imageWithData:data];
		if (successBlock) successBlock(data);
		
	}];
}

@end
