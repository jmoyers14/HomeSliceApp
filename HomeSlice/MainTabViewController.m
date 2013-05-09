//
//  MainTabViewController.m
//  HomeSlice
//
//  Created by Jeremy Moyers on 4/24/13.
//  Copyright (c) 2013 Jeremy Moyers. All rights reserved.
//

#import "MainTabViewController.h"

@interface MainTabViewController ()

@end

@implementation MainTabViewController

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
    self.selectedIndex = 1;
    
    
//    UITabBar *tabBar = [self tabBar];
//    if ([tabBar respondsToSelector:@selector(setBackgroundImage:)])
//    {
//        // ios 5 code here
//        //[tabBar setBackgroundImage:[UIImage imageNamed:@"TabBarBackgroundBlank.png"]];
//        [tabBar setBackgroundImage:[UIImage imageNamed:@"TabBarBlue.png"]];
//    }
//    else
//    {
//        // ios 4 code here
//        NSLog(@"goin onld school");
//        CGRect frame = CGRectMake(0, 0, 480, 49);
//        UIView *tabbg_view = [[UIView alloc] initWithFrame:frame];
//        UIImage *tabbag_image = [UIImage imageNamed:@"TabBarBlue.png"];
//        UIColor *tabbg_color = [[UIColor alloc] initWithPatternImage:tabbag_image];
//        tabbg_view.backgroundColor = tabbg_color;
//        [tabBar insertSubview:tabbg_view atIndex:0];
//        
//    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)tabBarController:(UITabBarController *)theTabBarController didSelectViewController:(UIViewController *)viewController
{
    NSUInteger indexOfTab = [theTabBarController.viewControllers indexOfObject:viewController];
    //NSLog(@"Tab index = %u (%u)", indexOfTab);
}

@end
