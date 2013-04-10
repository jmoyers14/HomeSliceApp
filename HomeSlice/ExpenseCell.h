//
//  ExpenseCell.h
//  HomeSlice
//
//  Created by Jeremy Moyers on 4/3/13.
//  Copyright (c) 2013 Jeremy Moyers. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ExpenseCell : UITableViewCell
@property (nonatomic, strong) IBOutlet UILabel *name;
@property (nonatomic, strong) IBOutlet UILabel *amount;

@end
