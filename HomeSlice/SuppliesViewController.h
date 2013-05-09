//
//  SuppliesViewController.h
//  HomeSlice
//
//  Created by Jeremy Moyers on 2/20/13.
//  Copyright (c) 2013 Jeremy Moyers. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SuppliesViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>


@property (nonatomic, strong) IBOutlet UITableView *tView;
@property (nonatomic, strong) NSMutableArray *supplies;

@end
