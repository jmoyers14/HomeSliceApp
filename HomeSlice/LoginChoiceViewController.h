//
//  LoginChoiceViewController.h
//  HomeSlice
//
//  Created by Jeremy Moyers on 4/24/13.
//  Copyright (c) 2013 Jeremy Moyers. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginChoiceViewController : UIViewController

@property (nonatomic, strong) IBOutlet UIActivityIndicatorView *spinner;

- (IBAction)performFBLogin:(id)sender;
- (void)performServerLogin;
- (void) loginFailed;




@end
