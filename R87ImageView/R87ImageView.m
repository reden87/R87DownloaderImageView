//
//  R87ImageView.m
//  R87ImageView
//
//  Created by Gergő Németh on 04/04/15.
//  Copyright (c) 2015 reden87. All rights reserved.
//

#import "R87ImageView.h"

#define R87CustomErrorDomain @"info.reden87"
#define HTTPErrorCode 1001
#define HTTPErrorMessage NSLocalizedString(@"Server response error!", nil)

@implementation R87ImageView

#pragma mark Lazy Instantiation

// getters
- (UIView *)activityIndicator {
	if (!_activityIndicator) {
		UIActivityIndicatorView *activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
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
	self.activityIndicator.center = CGPointMake(self.frame.size.width / 2.0, self.frame.size.height / 2.0);
	
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
