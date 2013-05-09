//
//  AppDelegate.h
//  HomeSlice
//
//  Created by Jeremy Moyers on 2/20/13.
//  Copyright (c) 2013 Jeremy Moyers. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import "LoginNavViewController.h"
#import "LoginChoiceViewController.h"
#import "DefaultViewController.h"
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) UITabBarController *mainTabController;
@property (strong, nonatomic) UINavigationController *loginNavController;
@property (strong, nonatomic) DefaultViewController *defaultView;


- (void)openSession;


@end
