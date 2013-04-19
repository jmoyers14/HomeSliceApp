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
@synthesize user      = _user;
@synthesize houseKey  = _houseKey;

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

        BOOL doSegue = [self joinHouse];
        
        if(doSegue)
            [self performSegueWithIdentifier:@"FromJoinHouse" sender:self];
    
    }
    return NO;
}


- (BOOL) joinHouse
{
    NSString *name = self.houseName.text;
    NSString *key = self.houseKey.text;
    
    if([name isEqualToString:@""])
    {
        [self showMessageWithTitle:@"Input error" andMessage:@"please input a house name"];
        return NO;
    }
    else if([key isEqualToString:@""])
    {
        [self showMessageWithTitle:@"Input error" andMessage:@"please input the unique house key for the house you wish to join"];
        return NO;
    }
    else
    {
        [self.user.person joinHouseWithName:name];
        return YES;
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