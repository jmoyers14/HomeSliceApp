//
//  CreateHouseViewController.m
//  HomeSlice
//
//  Created by Jeremy Moyers on 2/20/13.
//  Copyright (c) 2013 Jeremy Moyers. All rights reserved.
//

#import "CreateHouseViewController.h"
#import "Singleton.h"
@interface CreateHouseViewController ()

@end

@implementation CreateHouseViewController

@synthesize houseName = _houseName;
@synthesize housePassword = _housePassword;
@synthesize confirmHousePassword = _confirmHousePassword;
@synthesize rent = _rent;
@synthesize user = _user;


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.user = ((Singleton *)[Singleton sharedInstance]).user;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void) createUtility
{
    
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
    else if(textField == self.rent)
    {
        [self resignFirstResponder];
        NSNumber *rent = [NSNumber numberWithFloat:self.rent.text.floatValue];
        NSString *name = self.houseName.text;

        [self.user.person createHouseNamed:name withRent:rent];
        
        [self performSegueWithIdentifier:@"FromCreateHouse" sender:self];
        
    }
    
    return NO;
}


@end
