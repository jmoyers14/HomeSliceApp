//
//  WhiteBoardViewController.h
//  HomeSlice
//
//  Created by Jeremy Moyers on 4/3/13.
//  Copyright (c) 2013 Jeremy Moyers. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Network.h"
#import "Singleton.h"
#import "constatns.h"
@interface WhiteBoardViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) IBOutlet UITableView *tView;
@property (nonatomic, strong) NSMutableArray *posts;
@property (nonatomic, strong) NSMutableDictionary *roommates;
- (IBAction)newPost:(id)sender;
- (void)doneReloadingPosts;

@end
