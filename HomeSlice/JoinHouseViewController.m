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
    self.spinner.hidden = YES;
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
    else if(textField == self.houseKey)
    {
        [self.spinner startAnimating];
        [self resignFirstResponder];

        BOOL doSegue = [self joinHouse];
        [self.spinner stopAnimating];
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
        NSMutableDictionary *houseDict = [[NSMutableDictionary alloc] init];
        [houseDict setObject:name forKey:@"name"];
        [houseDict setObject:key  forKey:@"key"];
        NSArray *returnArray = [Network makeGetRequestWithData:houseDict toURL:HOUSE_URL];
        NSDictionary *dict = [returnArray objectAtIndex:0];
        
        if(dict == nil)
        {
            [self showMessageWithTitle:@"error:" andMessage:@"check network connection"];
            return NO;
        }
        if ([dict objectForKey:@"error"] != nil)
        {
            NSString *code = [NSString stringWithFormat:@"Error code:%@", [dict objectForKey:@"code"]];
            NSString *message = [dict objectForKey:@"error"];
            [self showMessageWithTitle:code andMessage:message];
            return NO;
        }
        else
        {
            NSString *houseId = [dict objectForKey:@"objectId"];
            self.user.person.house_id = houseId;
            [self.user.person createRelationshipForPersonWithHouse:houseId];
            
            //set up roommate objects
            NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];
            [parameters setObject:houseId forKey:@"house_id"];
            NSArray *roomies = [Network makeGetRequestForPosts:parameters toURL:PERSON_URL];
            [((Singleton *)[Singleton sharedInstance]) createRoomatesWithData:roomies];
        }
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