//
//  JoinHouseViewController.m
//  HomeSlice
//
//  Created by Jeremy Moyers on 3/4/13.
//  Copyright (c) 2013 Jeremy Moyers. All rights reserved.
//

#import "JoinHouseViewController.h"

@interface JoinHouseViewController ()

@end

@implementation JoinHouseViewController
@synthesize houseName = _houseName;
@synthesize user = _user;

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
    
    self.user = ((Singleton *)[Singleton sharedInstance]).user;
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma - mark text view delegate

- (BOOL) textFieldShouldReturn:(UITextField *)textField
{
    NSInteger nextTag = textField.tag + 1;
    
    UIResponder *nextResponder = [textField.superview viewWithTag:nextTag];
    
    if(nextResponder)
    {
        [nextResponder becomeFirstResponder];
    }
    else if(textField == self.houseName)
    {
        [self resignFirstResponder];

        NSString *name = self.houseName.text;
        [self.user.person joinHouseWithName:name];
        
        [self performSegueWithIdentifier:@"FromJoinHouse" sender:self];
    
    }
    return NO;
}

@end