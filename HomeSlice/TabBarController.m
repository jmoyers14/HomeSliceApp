//
//  TabBarController.m
//  HomeSlice
//
//  Created by Jeremy Moyers on 2/20/13.
//  Copyright (c) 2013 Jeremy Moyers. All rights reserved.
//

#import "TabBarController.h"

@interface TabBarController ()

@end

@implementation TabBarController

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
    self.selectedIndex = 2;
    
    
    UITabBar *tabBar = [self tabBar];
    if ([tabBar respondsToSelector:@selector(setBackgroundImage:)])
    {
        // ios 5 code here
        [tabBar setBackgroundImage:[UIImage imageNamed:@"TabBar.png"]];
        
    }
    else
    {
        // ios 4 code here
        NSLog(@"goin onld school");
        CGRect frame = CGRectMake(0, 0, 480, 49);
        UIView *tabbg_view = [[UIView alloc] initWithFrame:frame];
        UIImage *tabbag_image = [UIImage imageNamed:@"TabBar.png"];
        UIColor *tabbg_color = [[UIColor alloc] initWithPatternImage:tabbag_image];
        tabbg_view.backgroundColor = tabbg_color;
        [tabBar insertSubview:tabbg_view atIndex:0];
        
    }
    
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
