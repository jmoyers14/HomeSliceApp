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

/*
 * Sign up with email / password
 */
- (BOOL)submitUserInfo
{

    NSString *username = self.username.text;
    NSString *password = self.password.text;
    NSString *fullName = self.fullName.text;
    
    NSString *confirmPassword = self.confirmPassword.text;
    if([fullName isEqualToString:@""])
    {
        [self showMessageWithTitle:@"Input error:" andMessage:@"Please input full name"];
    }
    else if([username isEqualToString:@""])
    {
        [self showMessageWithTitle:@"Input error:" andMessage:@"Please input username"];
        return NO;
    }
    else if([password isEqualToString:@""]|| [confirmPassword isEqualToString:@""])
    {
        [self showMessageWithTitle:@"Input error" andMessage:@"please enter password and confirmation"];
        return NO;
    }
    if(![password isEqualToString:confirmPassword])
    {
        [self showMessageWithTitle:@"Passowrd error" andMessage:@"Password confirmation failed"];
        return NO;
    }
    else
    {
        NSMutableDictionary *userDictionary = [[NSMutableDictionary alloc] init];
        [userDictionary setObject:username forKey:@"username"];
        [userDictionary setObject:password forKey:@"password"];
        
        
        //attempt user signup
        NSDictionary *dict = [Network postObjectWithData:userDictionary toURL:USERS_URL];
        
        if(dict == nil)
        {
            [self showMessageWithTitle:@"error:" andMessage:@"check network connection"];
            return NO;
        }
        if([dict objectForKey:@"error"] != nil)
        {
            NSString *code = [NSString stringWithFormat:@"Error code:%@", [dict objectForKey:@"code"]];
            NSString *message = [dict objectForKey:@"error"];
            [self showMessageWithTitle:code andMessage:message];
            return NO;
        }
        else
        {
            [userDictionary setObject:[dict objectForKey:@"sessionToken"] forKey:@"sessionToken"];
            [userDictionary setObject:[dict objectForKey:@"objectId"] forKey:@"objectId"];
            [userDictionary setObject:fullName forKey:@"fullName"];
            ((Singleton*)[Singleton sharedInstance]).user = [[User alloc] initAfterSignup:userDictionary];
            return YES;
        }
    }
}







/*
 * Sign up with facebook
 */



- (void) showMessageWithTitle:(NSString *)title andMessage:(NSString *) message
{
    UIAlertView *mess = [[UIAlertView alloc] initWithTitle:title
                                                   message:message
                                                  delegate:nil
                                         cancelButtonTitle:@"OK"
                                         otherButtonTitles:nil];
    
    [mess show];
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
        BOOL doLogin = [self submitUserInfo];
        if(doLogin)
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
