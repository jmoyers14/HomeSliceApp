//
//  ExpensesViewController.h
//  HomeSlice
//
//  Created by Jeremy Moyers on 4/3/13.
//  Copyright (c) 2013 Jeremy Moyers. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Person.h"
#import "Network.h"
#import "Expense.h"
#import "ExpenseCell.h"
#import "Singleton.h"
#import "constatns.h"

@interface ExpensesViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) Person *displayPerson;
@property (nonatomic, strong) IBOutlet UITableView *tView;
@property (nonatomic, strong) NSMutableArray *expenses;
@property (nonatomic, strong) IBOutlet UILabel *nameTitle;
@end
