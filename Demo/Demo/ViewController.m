//
//  ViewController.m
//  Demo
//
//  Created by Gergő Németh on 04/04/15.
//  Copyright (c) 2015 reden87. All rights reserved.
//

#import "ViewController.h"

#define firstImageLink @"https://github.com/reden87/R87DownloaderImageView/raw/master/Assets/earth.png"
#define firstImageUserDefaultsKey @"fisrt image"
#define secondImageLink @"https://github.com/reden87/R87DownloaderImageView/raw/master/Assets/fox.jpg"
#define secondImageUserDefaultsKey @"second image"

@implementation ViewController

#pragma mark - Actions

- (IBAction)addImages {
	
	NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
	
	// set first image if exists
	NSData *imageData = [userDefaults objectForKey:firstImageUserDefaultsKey];
	self.firstImageView.image = [UIImage imageWithData:imageData];
	
	// download first image (sets the image and does nothing if the image exists)
	[self.firstImageView downloadImageWithLink:firstImageLink withSuccessBlock:^(NSData *imageData) {
		
		[userDefaults setObject:imageData forKey:firstImageUserDefaultsKey];
		[userDefaults synchronize];
		
	} failureBlock:^(NSError *error) {
		
#if TARGET_OS_TV
		UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"Error" message:error.localizedDescription preferredStyle:UIAlertControllerStyleAlert];
		
		UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
		[alertVC addAction:okAction];
		
		[self presentViewController:alertVC animated:YES completion:nil];
#else
		[[[UIAlertView alloc] initWithTitle:@"Error" message:error.localizedDescription delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
#endif
		
	}];
	
	
	
	// set second image if exists
	imageData = [userDefaults objectForKey:secondImageUserDefaultsKey];
	self.secondImageView.image = [UIImage imageWithData:imageData];
	
	// sets custom loading image
	UIImageView *loadingAnimation = [[UIImageView alloc] initWithFrame:CGRectMake(0.0, 0.0, 101.0, 30.0)];
	NSMutableArray *animationImages = [[NSMutableArray alloc] initWithCapacity:22];
	for (NSInteger i = 1; i <= 22; i++) {
		NSString *imageName = [NSString stringWithFormat:@"anim%tu", i];
		[animationImages addObject:[UIImage imageNamed:imageName]];
	}
	loadingAnimation.animationImages = animationImages;
	loadingAnimation.animationDuration = 1.0;
	[loadingAnimation startAnimating];
	self.secondImageView.activityIndicator = loadingAnimation;
	
	// download second image (sets the image and does nothing if the image exists)
	[self.secondImageView downloadImageWithLink:secondImageLink withSuccessBlock:^(NSData *imageData) {
		
		[userDefaults setObject:imageData forKey:secondImageUserDefaultsKey];
		[userDefaults synchronize];
		
	} failureBlock:^(NSError *error) {
		
#if TARGET_OS_TV
		UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"Error" message:error.localizedDescription preferredStyle:UIAlertControllerStyleAlert];
		
		UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
		[alertVC addAction:okAction];
		
		[self presentViewController:alertVC animated:YES completion:nil];
#else
		[[[UIAlertView alloc] initWithTitle:@"Error" message:error.localizedDescription delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
#endif
		
	}];
	
}

@end
