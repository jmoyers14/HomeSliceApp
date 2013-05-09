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

- (BOOL) createHouse
{
    NSString *name     = self.houseName.text;
    NSString *key      = self.houseKey.text;
    NSString *rent     = self.rent.text;
    
    
    if([name isEqualToString:@""])
    {
        [self showMessageWithTitle:@"Input error" andMessage:@"please input a house name."];
        return NO;
    }
    else if([key isEqualToString:@""])
    {
        [self showMessageWithTitle:@"Input error" andMessage:@"please input a house key."];
        return NO;
    }
    else if([rent isEqualToString:@""])
    {
        [self showMessageWithTitle:@"Input error" andMessage:@"please input rent amount."];
        return NO;
    }
    else
    {
        NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
        [dict setObject:self.user.person.person_id forKey:@"person_id"];
        [dict setObject:name forKey:@"name"];
        [dict setObject:[NSNumber numberWithFloat:[rent floatValue]] forKey:@"rent"];
        [dict setObject:key forKey:@"key"];
        NSDictionary *returnData = [Network postObjectWithData:dict toURL:HOUSE_URL];
        
        if(returnData == nil)
        {
            [self showMessageWithTitle:@"Error" andMessage:@"Check your network connection"];
            return NO;
        }
        else if([returnData objectForKey:@"error"] != nil)
        {
            NSString *error = [returnData objectForKey:@"error"];
            NSString *code = [NSString stringWithFormat:@"Error code:%@", [returnData objectForKey:@"code"]];
            [self showMessageWithTitle:code andMessage:error];
            return NO;
        }
        else
        {
            self.user.person.house_id = [returnData objectForKey:@"objectId"];
            
            //set up roommate object
            NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];
            [parameters setObject:self.user.person.house_id forKey:@"house_id"];
            NSArray *roomies = [Network makeGetRequestForPosts:parameters toURL:PERSON_URL];
            [((Singleton *)[Singleton sharedInstance]) createRoomatesWithData:roomies];
    
            return YES;
        }
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
        
        BOOL doSegue = [self createHouse];
        
        if(doSegue)
            [self performSegueWithIdentifier:@"FromCreateHouse" sender:self];
        
    }
    
    return NO;
}


@end
