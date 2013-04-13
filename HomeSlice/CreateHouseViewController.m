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
@synthesize houseKey = _houseKey;
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

- (void) createHouse
{
    NSString *name     = self.houseName.text;
    NSString *key = self.houseKey.text;
    NSString *rent     = self.rent.text;
    
    
    if([name isEqualToString:@""])
    {
        [self showMessageWithTitle:@"Input error" andMessage:@"please input a house name."];
    }
    else if([key isEqualToString:@""])
    {
        [self showMessageWithTitle:@"Input error" andMessage:@"please input a house key."];
    }
    else if([rent isEqualToString:@""])
    {
        [self showMessageWithTitle:@"Input error" andMessage:@"please input rent amount."];
    }
    else
    {
        NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
        [dict setObject:name forKey:@"name"];
        [dict setObject:rent forKey:@"rent"];
        [dict setObject:key forKey:@"key"];
        NSDictionary *returnData = [Network postObjectWithData:dict toURL:HOUSE_URL];
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
