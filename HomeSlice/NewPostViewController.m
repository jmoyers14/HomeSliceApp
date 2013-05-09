//
//  NewPostViewController.m
//  HomeSlice
//
//  Created by Jeremy Moyers on 4/25/13.
//  Copyright (c) 2013 Jeremy Moyers. All rights reserved.
//

#import "NewPostViewController.h"

@interface NewPostViewController ()

@end

@implementation NewPostViewController
@synthesize keyboardToolbar = _keyboardToolbar;
@synthesize textView = _textView;
@synthesize spinner = _spinner
;
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
    self.textView.layer.cornerRadius = 5;
    self.textView.layer.shadowColor  = (__bridge CGColorRef)([UIColor blackColor]);
    self.textView.layer.shadowOffset = CGSizeMake(4.0, 4.0);
    self.spinner.hidden = YES;

    
}

- (void) viewWillAppear:(BOOL)animated
{
    //add keyboard observers
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    //[self.textView becomeFirstResponder];
}

- (void) viewDidAppear:(BOOL)animated
{
    [self.textView becomeFirstResponder];
}

- (void) viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

- (IBAction)hideKeyboard:(id)sender {
    [self.spinner startAnimating];
	[self.textView resignFirstResponder];
    
    if(![self.textView.text isEqualToString:@""])
    {
        User *user = ((Singleton *)[Singleton sharedInstance]).user;
        NSMutableDictionary *postDict = [[NSMutableDictionary alloc] init];
        [postDict setObject:user.person.person_id forKey:@"poster_id"];
        [postDict setObject:[NSNumber numberWithInt:1] forKey:@"type"];
        [postDict setObject:self.textView.text forKey:@"message"];
        [postDict setObject:user.person.house_id forKey:@"house_id"];
        
        [Network postObjectWithData:postDict toURL:POST_URL];
        [self.navigationController popViewControllerAnimated:YES];
    }
    else
    {
        [self showMessageWithTitle:@"Input Error" andMessage:@"Post body is blank"];
    }
    [self.spinner stopAnimating];
    self.spinner.hidden = YES;
    
}

- (void)keyboardWillShow:(NSNotification *)notification {
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3];
    
    CGRect frame = self.keyboardToolbar.frame;

    frame.origin.y = self.view.frame.size.height - 210.0;
    self.keyboardToolbar.frame = frame;
    
    [UIView commitAnimations];
}

- (void)keyboardWillHide:(NSNotification *)notification {
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:0.3];
    
	CGRect frame = self.keyboardToolbar.frame;
	frame.origin.y = self.view.frame.size.height;
	self.keyboardToolbar.frame = frame;
    
	[UIView commitAnimations];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)postMessage:(id)sender
{
    if(![self.textView.text isEqualToString:@""])
    {
        User *user = ((Singleton *)[Singleton sharedInstance]).user;
        NSMutableDictionary *postDict = [[NSMutableDictionary alloc] init];
        [postDict setObject:user.person.person_id forKey:@"poster_id"];
        [postDict setObject:[NSNumber numberWithInt:1] forKey:@"type"];
        [postDict setObject:self.textView.text forKey:@"message"];
        [postDict setObject:user.person.house_id forKey:@"house_id"];
        
        [Network postObjectWithData:postDict toURL:POST_URL];
        [self.navigationController popViewControllerAnimated:YES];
    }
    else
    {
        [self showMessageWithTitle:@"Input Error" andMessage:@"Post body is blank"];
    }
}

- (void) showMessageWithTitle:(NSString *)title andMessage:(NSString *) message
{
    UIAlertView *mess = [[UIAlertView alloc] initWithTitle:title
                                                   message:message
                                                  delegate:nil
                                         cancelButtonTitle:@"OK"
                                         otherButtonTitles:nil];
    
    [mess show];
}




@end
