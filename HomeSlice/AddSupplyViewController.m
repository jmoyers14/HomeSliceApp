//
//  AddSupplyViewController.m
//  HomeSlice
//
//  Created by Jeremy Moyers on 5/6/13.
//  Copyright (c) 2013 Jeremy Moyers. All rights reserved.
//

#import "AddSupplyViewController.h"
#import "Network.h"
#import "Singleton.h"
#import "constatns.h"
@interface AddSupplyViewController ()

@end

@implementation AddSupplyViewController
@synthesize supplyName = _supplyName;
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
	// Do any additional setup after loading the view.
    [self.supplyName becomeFirstResponder];
    self.spinner.hidden = YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma - mark UITextFieldDelegate

- (BOOL) textFieldShouldReturn:(UITextField *)textField
{
    if (textField.tag == 0)
    {
        [self.spinner startAnimating];
        BOOL success = [self postSupply];
        [self.spinner stopAnimating];
        [self.spinner setHidden:YES];
        
        if(success)
            [self.navigationController popViewControllerAnimated:YES];

    }
    return YES;
}

- (BOOL)postSupply
{
    [self.spinner startAnimating];
    NSString *supply = self.supplyName.text;
    NSMutableDictionary *postData = [[NSMutableDictionary alloc] init];
    
    NSString *houseId = ((Singleton *)[Singleton sharedInstance]).user.person.house_id;
    
    [postData setObject:supply forKey:@"name"];
    [postData setObject:[NSNumber numberWithBool:YES] forKey:@"stocked"];
    [postData setObject:houseId forKey:@"house_id"];
    NSDictionary *returnData = [Network postObjectWithData:postData toURL:SUPPLY_URL];
    
    
    if(returnData == nil)
    {
        [self showMessageWithTitle:@"Error" andMessage:@"Check your network connection"];
        return NO;
    }
    if([returnData objectForKey:@"error"] != nil)
    {
        NSString *error = [returnData objectForKey:@"error"];
        NSString *code = [NSString stringWithFormat:@"Error code:%@", [returnData objectForKey:@"code"]];
        [self showMessageWithTitle:code andMessage:error];
        return NO;
    }
    else
    {
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
