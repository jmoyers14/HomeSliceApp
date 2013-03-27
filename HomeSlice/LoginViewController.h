//
//  LoginViewController.h
//  HomeSlice
//
//  Created by Jeremy Moyers on 2/20/13.
//  Copyright (c) 2013 Jeremy Moyers. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomTextField.h"
#import "User.h"
@interface LoginViewController : UIViewController <UITextFieldDelegate>

@property (nonatomic, strong) IBOutlet CustomTextField *email;
@property (nonatomic, strong) IBOutlet CustomTextField *password;

- (void) loginUser;

@end
