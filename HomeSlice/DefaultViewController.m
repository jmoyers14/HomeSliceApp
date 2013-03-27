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



- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


- (void) viewDidAppear:(BOOL)animated
{
    if(![PFUser currentUser])
    {
        //user not logged in
        [self performSegueWithIdentifier:@"GoToLogin" sender:self];
    }
    else
    {
        [self performSegueWithIdentifier:@"GoToApp" sender:self];
    }
}

@end
