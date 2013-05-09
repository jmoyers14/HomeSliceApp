//
//  DefaultViewController.m
//  HomeSlice
//
//  Created by Jeremy Moyers on 2/24/13.
//  Copyright (c) 2013 Jeremy Moyers. All rights reserved.
//

#import "DefaultViewController.h"

@interface DefaultViewController ()

@end

@implementation DefaultViewController
@synthesize spinner = _spinner;


- (void)viewDidLoad
{
    [super viewDidLoad];


    
    
}


- (void) viewDidAppear:(BOOL)animated
{
    [self.spinner startAnimating];
    if (FBSession.activeSession.isOpen) {
        [self populateUserDetails];
    }
}

- (void)populateUserDetails
{
    NSLog(@"we even trying?");
    if (FBSession.activeSession.isOpen)
    {
        [[FBRequest requestForMe] startWithCompletionHandler:
         ^(FBRequestConnection *connection, NSDictionary<FBGraphUser> *user, NSError *error) {
             if (!error)
             {
                 [self parseAuthenticateUser:user];
             }
         }];
    }
}

- (void) parseAuthenticateUser:(NSDictionary<FBGraphUser> *) user
{
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard_iPhone" bundle:nil];
    LoginNavViewController *loginView = [storyboard instantiateViewControllerWithIdentifier:@"LoginNav"];
    
    NSString *accessToken          = FBSession.activeSession.accessTokenData.accessToken;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"];
    
    NSString *expirationDate      = [dateFormatter stringFromDate:[NSDate date]];
    NSMutableDictionary *data     = [[NSMutableDictionary alloc] init];
    NSMutableDictionary *authData = [[NSMutableDictionary alloc] init];
    NSMutableDictionary *facebook = [[NSMutableDictionary alloc] init];
    
    [facebook setObject:user.id forKey:@"id"];
    [facebook setObject:accessToken forKey:@"access_token"];
    [facebook setObject:expirationDate forKey:@"expiration_date"];
    [authData setObject:facebook forKey:@"facebook"];
    [data     setObject:authData forKey:@"authData"];
    
    NSDictionary *returnData = [Network postObjectWithData:data toURL:USERS_URL];
    
    if(returnData == nil)
    {
        [self showMessageWithTitle:@"Error" andMessage:@"Check your network connection"];
        [self presentViewController:loginView animated:NO completion:nil];

    }
    else if([returnData objectForKey:@"error"] != nil)
    {
        NSString *error = [returnData objectForKey:@"error"];
        NSString *code = [NSString stringWithFormat:@"Error code:%@", [returnData objectForKey:@"code"]];
        [self showMessageWithTitle:code andMessage:error];
        [self presentViewController:loginView animated:NO completion:nil];
    }
    else
    {
        NSLog(@"Success authenticating user on server");
        if([returnData objectForKey:@"person_id"] != nil)
        {
            //returning user
            ((Singleton*)[Singleton sharedInstance]).user = [[User alloc] initAfterFbLogin:user withData:returnData];
            
            NSString *houseId = ((Singleton *)[Singleton sharedInstance]).user.person.house_id;
            [self createRoommatesForHouseId:houseId];
            
            [self.spinner stopAnimating];
            self.spinner.hidden = YES;
            [self performSegueWithIdentifier:@"PostFB" sender:self];
        }
        else
        {
            //new user
            ((Singleton*)[Singleton sharedInstance]).user = [[User alloc] initAfterFbSignup:user withDAta:returnData];
            
            [self.spinner stopAnimating];
            self.spinner.hidden = YES;
            [self performSegueWithIdentifier:@"CreateHouseAfterFB" sender:self];
        }
    }
}

- (void) createRoommatesForHouseId:(NSString *)houseId
{
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];
    [parameters setObject:houseId forKey:@"house_id"];
    NSArray *roomies = [Network makeGetRequestForPosts:parameters toURL:PERSON_URL];
    [((Singleton *)[Singleton sharedInstance]) createRoomatesWithData:roomies];
}

- (void) createPersonForUser:(NSDictionary<FBGraphUser>*)user withData:(NSDictionary *)data
{
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
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

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"PostFB"])
    {
        //MainTabViewController *vc = (MainTabViewController*)segue.destinationViewController;
        //[vc.tabBar setSelectedItem:[vc.tabBar.items objectAtIndex:1]];
    }
}


@end
