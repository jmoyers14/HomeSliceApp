//
//  HomeViewController.h
//  HomeSlice
//
//  Created by Jeremy Moyers on 2/20/13.
//  Copyright (c) 2013 Jeremy Moyers. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GraphCell.h"
#import "ExpensesViewController.h"
@interface HomeViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, GraphCellProtocol>



@property (strong, nonatomic) NSMutableArray *roommates;
@property (strong, nonatomic) IBOutlet UITableView *tView;


-(void)showExpensesFor:(NSInteger)index;
-(void)updateRentForPerson:(NSInteger)index byAmount:(float)rent;
@end
