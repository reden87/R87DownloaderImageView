# Overview

R87ImageView is a `UIImageView` subclass which makes possible to download image from the provided link. While the download is in progress the default or a custom propgress bar is displayed, the download returns a success or failure block.

# Usage

Use this method to start image download from a server:

```objective-c
- (void)downloadImageWithLink:(NSString *)imageLink
			 withSuccessBlock:(void(^)(NSData *imageData))successBlock
				 failureBlock:(void(^)(NSError *error))failureBlock;
```

Optionally you can set the `image` property before the `downloadImageWithLink:withSuccessBlock:failureBlock` method. In this case the method does nothing.

You can set the `activityIndicator` property before the `downloadImageWithLink:withSuccessBlock:failureBlock` method. In this case the the provided view vill be displayed while the download is in progress.

You can set the `errorImage` property before the `downloadImageWithLink:withSuccessBlock:failureBlock` method. This image will be displayed if an error occures.

# Example

```objective-c
NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];

// set image if exists
NSData *imageData = [userDefaults objectForKey:@"image"];
self.imageView.image = [UIImage imageWithData:imageData];

// set custom loading indicator
UIActivityIndicatorView *activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
[activityIndicator startAnimating];
self.imageView.activityIndicator = activityIndicator;

// set error image
self.imageView.errorImage = [UIImage imageNamed:@"errorImage"];

// download image (does nothing if the image exists)
[self.imageView downloadImageWithLink:@"http://lorempixel.com/400/400/" withSuccessBlock:^(NSData *imageData) {
	
	[userDefaults setObject:imageData forKey:@"image"];
	[userDefaults synchronize];
	
} failureBlock:nil];
```

# License

The project is under the MIT License.

# Todo

* Create CocoaPod
* Ideas?

# About

Gergő Németh (reden87)

* [LinkedIn](https://www.linkedin.com/in/reden87)
* [Twitter](https://twitter.com/reden87)
* [GitHub](https://github.com/reden87)
* [Skype](skype:reden87?chat)