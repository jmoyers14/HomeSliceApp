//
//  LoginViewController.m
//  HomeSlice
//
//  Created by Jeremy Moyers on 2/20/13.
//  Copyright (c) 2013 Jeremy Moyers. All rights reserved.
//

#import "LoginViewController.h"
#import "Singleton.h"

@interface LoginViewController ()

@end

@implementation LoginViewController
@synthesize email = _email;
@synthesize password = _password;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self.email becomeFirstResponder];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



/*
 * Log user in with email / password
 */
- (BOOL)loginUser
{
    NSString *username = self.email.text;
    NSString *password = self.password.text;
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    NSDictionary *userData;
    [dict setObject:username forKey:@"username"];
    [dict setObject:password forKey:@"password"];
    
    if([username isEqualToString:@""])
    {
        [self showMessageWithTitle:@"Input error" andMessage:@"Please enter a username"];
        return NO;
    }
    else if([password isEqualToString:@""])
    {
        return NO;
        [self showMessageWithTitle:@"Input error" andMessage:@"Please enter a password."];
    }
    else
    {
        userData = [Network makeLoginGetRequestWithData:dict toURL:LOGIN_URL];
        if(userData == nil)
        {
            [self showMessageWithTitle:@"Login Error" andMessage:@"Check your network connection"];
            return NO;
        }
        else if([userData objectForKey:@"error"] != nil)
        {
            NSString *code = [NSString stringWithFormat:@"error code:%@", [dict objectForKey:@"code"]];
            NSString *error =  [dict objectForKey:@"error"];
            [self showMessageWithTitle:code andMessage:error];
            return NO;
        }
        else
        {
            ((Singleton *)[Singleton sharedInstance]).user = [[User alloc] initAfterLogin:userData];
            return YES;
        }
    }
}




/*
 * Log user in with facebook
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
    else if(textField == self.password)
    {
        [self resignFirstResponder];
        
        BOOL doLogin = [self loginUser];
        
        if(doLogin)
        {
            [self performSegueWithIdentifier:@"FromLogin" sender:self];
        }
    }
    
    return NO;
}

@end
