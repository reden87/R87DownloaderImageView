# R87DownloaderImageView

[![Cocoapods](https://img.shields.io/cocoapods/v/R87DownloaderImageView.svg)](http://cocoapods.org/pods/R87DownloaderImageView)
[![Issues](https://img.shields.io/github/issues/reden87/R87DownloaderImageView.svg?style=flat)](https://github.com/reden87/R87DownloaderImageView/issues?state=open)
[![Platform](http://img.shields.io/badge/platform-ios-blue.svg?style=flat)](https://developer.apple.com/iphone/)
[![Language](http://img.shields.io/badge/language-objc-brightgreen.svg?style=flat)](https://developer.apple.com/library/ios/documentation/Cocoa/Conceptual/ProgrammingWithObjectiveC/)
[![License](http://img.shields.io/badge/license-MIT-lightgrey.svg?style=flat)](https://github.com/reden87/R87DownloaderImageView/blob/master/LICENSE)

## Overview

`R87DownloaderImageView` is a `UIImageView` subclass which makes possible to download an image from the provided link.

While the download is in progress the default or a custom propgress bar is displayed, the download returns a success block with the downloaded image or a failure block in case of an error.

![R87DownloaderImageView example image](http://reden87.info/GitHub/R87ImageView.gif)

## Installation

R87DownloaderImageView is available through [CocoaPods](http://cocoapods.org). To install it, simply add the following line to your Podfile:

```ruby
pod "R87DownloaderImageView"
```

## Usage

Use this method to start image download from a server:

```objective-c
- (void)downloadImageWithLink:(NSString *)imageLink
			 withSuccessBlock:(void(^)(NSData *imageData))successBlock
				 failureBlock:(void(^)(NSError *error))failureBlock;
```

Optionally you can set the `image` property before the `downloadImageWithLink:withSuccessBlock:failureBlock` method. In this case the method returns in the success block with nil parameter.

You can set the `activityIndicator` property before the `downloadImageWithLink:withSuccessBlock:failureBlock` method. In this case the the provided view vill be displayed while the download is in progress.

You can set the `errorImage` property before the `downloadImageWithLink:withSuccessBlock:failureBlock` method. This image will be displayed if an error occures.

## Example

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

## Compatibility

iOS 5.0+

## Contributing

Contributions are always welcome! (:

1. Fork it ( http://github.com/reden87/R87DownloaderImageView/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## License

The project is under the [MIT License](/LICENSE).

## Todo

* ~~Create CocoaPod~~ ✓
* make an internal image save solution where you can access an image with a custom ID you provided

## About

Gergő Németh (reden87)

* [LinkedIn](https://www.linkedin.com/in/reden87)
* [Twitter](https://twitter.com/reden87)
* [GitHub](https://github.com/reden87)
