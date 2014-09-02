//
//  PGAppDelegate.m
//  PGCoreImage
//
//  Created by PC Nguyen on 8/29/14.
//  Copyright (c) 2014 PC Nguyen. All rights reserved.
//

#import "PGAppDelegate.h"
#import "PGImageViewController.h"

@implementation PGAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
	
	PGImageViewController *imageViewController = [[PGImageViewController alloc] init];
	UINavigationController *navigationHolder = [[UINavigationController alloc] initWithRootViewController:imageViewController];
	self.window.rootViewController = navigationHolder;
	
    [self.window makeKeyAndVisible];
    return YES;
}

@end
