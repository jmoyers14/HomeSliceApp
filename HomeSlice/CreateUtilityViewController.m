//
//  CreateUtilityViewController.m
//  HomeSlice
//
//  Created by Jeremy Moyers on 3/5/13.
//  Copyright (c) 2013 Jeremy Moyers. All rights reserved.
//

#import "CreateUtilityViewController.h"

@interface CreateUtilityViewController ()

@end

@implementation CreateUtilityViewController
@synthesize accountNumber = _accountNumber;
@synthesize name = _name;
@synthesize website = _website;
@synthesize provider = _provider;
@synthesize utility = _utility;

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)createNewUtility:(id)sender
{
    NSMutableDictionary *utilityDict = [[NSMutableDictionary alloc] init];
    [utilityDict setObject:self.accountNumber.text forKey:@"account_number"];
    [utilityDict setObject:self.name.text forKey:@"name"];
    [utilityDict setObject:self.website forKey:@"website"];
    [utilityDict setObject:self.provider forKey:@"provider"];
    self.utility = [[Utility alloc] initWithDictionary:utilityDict];
    
}



@end
