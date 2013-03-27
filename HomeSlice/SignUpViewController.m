//
//  SignUpViewController.m
//  HomeSlice
//
//  Created by Jeremy Moyers on 2/20/13.
//  Copyright (c) 2013 Jeremy Moyers. All rights reserved.
//

#import "SignUpViewController.h"



@implementation SignUpViewController
@synthesize username        = _username;
@synthesize password        = _password;
@synthesize confirmPassword = _confirmPassword;
@synthesize usernameWarning = _usernameWarning;
@synthesize passwordWarning = _passwordWarning;
@synthesize fullName        = _fullName;

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.confirmPassword.delegate = self;
    self.username.delegate = self;
    self.password.delegate = self;
    [self.fullName becomeFirstResponder];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)submitUserInfo
{

    NSString *username = self.username.text;
    NSString *password = self.password.text;
    NSString *fullName = self.fullName.text;
    
    NSString *confirmPassword = self.confirmPassword.text;
    
    if([username isEqualToString:@""])
    {
        self.usernameWarning.text = @"Please input username.";
    }
    else if([password isEqualToString:@""]|| [confirmPassword isEqualToString:@""])
    {
        self.passwordWarning.text = @"Please enter password and confirmation";
    }
    if(![password isEqualToString:confirmPassword])
    {
        self.passwordWarning.text = @"password confirmation failed";
    }
    else
    {
        NSMutableDictionary *userDictionary = [[NSMutableDictionary alloc] init];
        [userDictionary setObject:username forKey:@"username"];
        [userDictionary setObject:password forKey:@"password"];
        [userDictionary setObject:fullName forKey:@"fullName"];
        ((Singleton*)[Singleton sharedInstance]).user = [[User alloc] initWithDictionary:userDictionary];
    }
}

#pragma -- mark UITextFieldDelegate

- (BOOL) textFieldShouldReturn:(UITextField *)textField
{
    NSInteger nextTag = textField.tag + 1;
    
    UIResponder *nextResponder = [textField.superview viewWithTag:nextTag];
    
    if(nextResponder)
    {
        [nextResponder becomeFirstResponder];
    }
    else if(textField == self.confirmPassword)
    {
        [self resignFirstResponder];
        [self submitUserInfo];
        if(((Singleton*)[Singleton sharedInstance]).user.loggedIn)
        {
            [self performSegueWithIdentifier:@"GoToChoice" sender:self];
        }
    }
    
    return NO;
}


//- (BOOL) textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
//{
//    if ([string isEqualToString:@"\n"]) {
//        
//        [textField resignFirstResponder];
//        // Return FALSE so that the final '\n' character doesn't get added
//        return NO;
//    }
//    // For any other character return TRUE so that the text gets added to the view
//    return YES;
//}

@end
