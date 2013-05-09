//
//  AppDelegate.m
//  HomeSlice
//
//  Created by Jeremy Moyers on 2/20/13.
//  Copyright (c) 2013 Jeremy Moyers. All rights reserved.
//

#import "AppDelegate.h"
#import "GAI.h"
#import "Singleton.h"
#import "FacebookSDK/FacebookSDK.h"
#import "LoginChoiceViewController.h"
@implementation AppDelegate
@synthesize mainTabController = _mainTabController;
@synthesize loginNavController = _loginNavController;


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    //set up UIAppearance
    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"NavBarTrim.png"] forBarMetrics:UIBarMetricsDefault];
    [[UITabBar appearance] setSelectionIndicatorImage:[[UIImage alloc] init]];
    //[[UITabBar appearance] setTintColor:[UIColor grayColor]];
    [[UIBarButtonItem appearance] setTintColor:[UIColor blueColor]];
    
    /*
     *Register PARSE application ID
     */
    [Parse setApplicationId:@"xdX1BJEdWu4leiKM2FRpsYHsh8sDTYsmjXGXNW8k"
                  clientKey:@"fqf3NHjKiJ3r3QJcPPWAuIxf5gcwm11bnUPokV4H"];
    
    
    
    /*
     *Register Google Analytics
     */
    // Optional: automatically send uncaught exceptions to Google Analytics.
    [GAI sharedInstance].trackUncaughtExceptions = YES;
    // Optional: set Google Analytics dispatch interval to e.g. 20 seconds.
    [GAI sharedInstance].dispatchInterval = 20;
    // Optional: set debug to YES for extra debugging information.
    [GAI sharedInstance].debug = YES;
    // Create tracker instance.
    id<GAITracker> tracker = [[GAI sharedInstance] trackerWithTrackingId:@"UA-40015847-1"];
    ((Singleton *)[Singleton sharedInstance]).tracker = tracker;
    
//    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard_iPhone" bundle:nil];
//    self.mainTabController   = [storyboard instantiateViewControllerWithIdentifier:@"MainTab"];
//    self.window.rootViewController = self.mainTabController;

    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard_iPhone" bundle:nil];
    self.defaultView = [storyboard instantiateViewControllerWithIdentifier:@"DefaultView"];
    self.window.rootViewController = self.defaultView;
    [self.window makeKeyAndVisible];
    
    
    if (FBSession.activeSession.state == FBSessionStateCreatedTokenLoaded) {
        [self openSession];
    } else {
        [self showLoginView];
    }
    
    
    return YES;
}

- (void) showLoginView
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard_iPhone" bundle:nil];
    UIViewController *modalViewController = [self.defaultView presentedViewController];
    
    
    if(![modalViewController isKindOfClass:[LoginNavViewController class]])
    {
        self.loginNavController = [storyboard instantiateViewControllerWithIdentifier:@"LoginNav"];
        [self.defaultView presentViewController:self.loginNavController animated:NO completion:nil];
    }
    else
    {
        self.loginNavController = (LoginNavViewController *)modalViewController;
        [((LoginChoiceViewController *)[self.loginNavController topViewController]) loginFailed];
    }
}

- (void) sessionStateChanged:(FBSession *)session state:(FBSessionState) state error:(NSError *)error
{


    //UIViewController *topViewController = [self.mainTabController.viewControllers objectAtIndex:1];

    switch (state) {
        case FBSessionStateOpen:
            if([[self.defaultView presentedViewController] isKindOfClass:[LoginNavViewController class]])
            {
                [self.defaultView dismissViewControllerAnimated:YES completion:nil];
            }
            break;
        
        case FBSessionStateClosed:
            break;
            
        case FBSessionStateClosedLoginFailed:
            NSLog(@"login failed... well figure out what to do later");
            break;
            
            
        default:
            break;
    }
    
    if (error)
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:error.localizedDescription delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alertView show];
    }
}



- (void)openSession
{
    [FBSession openActiveSessionWithReadPermissions:nil allowLoginUI:YES completionHandler:
        ^(FBSession *session,FBSessionState state, NSError *error) {
            [self sessionStateChanged:session state:state error:error];
    }];
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    return [FBSession.activeSession handleOpenURL:url];
}


- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    [FBSession.activeSession handleDidBecomeActive];
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
