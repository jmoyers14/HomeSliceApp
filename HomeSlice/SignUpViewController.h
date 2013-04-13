//
//  SignUpViewController.h
//  HomeSlice
//
//  Created by Jeremy Moyers on 2/20/13.
//  Copyright (c) 2013 Jeremy Moyers. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomTextField.h"
#import "Person.h"
#import "User.h"
#import "Singleton.h"

@interface SignUpViewController : UIViewController <UITextFieldDelegate>


@property (nonatomic, strong) IBOutlet UITextField *username;
@property (nonatomic, strong) IBOutlet CustomTextField *password;
@property (nonatomic, strong) IBOutlet CustomTextField *confirmPassword;
@property (nonatomic, strong) IBOutlet UILabel *usernameWarning;
@property (nonatomic, strong) IBOutlet UILabel *passwordWarning;
@property (nonatomic, strong) IBOutlet CustomTextField *fullName;

- (BOOL) submitUserInfo;



@end
