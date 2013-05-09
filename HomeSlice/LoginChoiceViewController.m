//
//  LoginChoiceViewController.m
//  HomeSlice
//
//  Created by Jeremy Moyers on 4/24/13.
//  Copyright (c) 2013 Jeremy Moyers. All rights reserved.
//

#import "LoginChoiceViewController.h"
#import "AppDelegate.h"

@interface LoginChoiceViewController ()

@end

@implementation LoginChoiceViewController
@synthesize spinner = _spinner;

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
    self.spinner.hidden = YES;
    self.navigationController.navigationBar.hidden = YES;
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)performFBLogin:(id)sender
{
    
    [self.spinner startAnimating];
    
    AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    [appDelegate openSession];
}

- (void) performServerLogin
{
    NSLog(@"PerformServerLogin");
}

- (void) loginFailed
{
    [self.spinner stopAnimating];
}

@end
