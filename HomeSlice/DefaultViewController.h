//
//  DefaultViewController.h
//  HomeSlice
//
//  Created by Jeremy Moyers on 2/24/13.
//  Copyright (c) 2013 Jeremy Moyers. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Parse/Parse.h"
#import "FacebookSDK/FacebookSDK.h"
#import "Network.h"
#import "constatns.h"
#import "User.h"
#import "Singleton.h"
#import "LoginNavViewController.h"
#import "MainTabViewController.h"
@interface DefaultViewController : UIViewController
@property (nonatomic, strong) IBOutlet UIActivityIndicatorView *spinner;

- (void) parseAuthenticateUser:(NSDictionary<FBGraphUser> *) user;


@end

