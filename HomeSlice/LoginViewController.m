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


- (void)loginUser
{
    NSString *username = self.email.text;
    NSString *password = self.password.text;
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    [dict setObject:username forKey:@"username"];
    [dict setObject:password forKey:@"password"];
    
    ((Singleton *)[Singleton sharedInstance]).user = [[User alloc] initWithLoginDictionary:dict];
    
}

/*
 * Log user in with email / password
 */


/*
 * Log user in with facebook
 */




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
        
        [self loginUser];
        
        if(((Singleton*)[Singleton sharedInstance]).user.loggedIn)
        {
            [self performSegueWithIdentifier:@"FromLogin" sender:self];
        }
    }
    
    return NO;
}

@end
