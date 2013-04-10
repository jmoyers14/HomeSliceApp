//
//  GraphCell.h
//  HomeSlice
//
//  Created by Jeremy Moyers on 3/31/13.
//  Copyright (c) 2013 Jeremy Moyers. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol GraphCellProtocol <NSObject>

@required
-(void)showExpensesFor:(NSInteger)index;
-(void)updateRentForPerson:(NSInteger)index byAmount:(float)rent;
@end


@interface GraphCell : UITableViewCell <UITextFieldDelegate>

@property (nonatomic, assign) NSInteger index;
@property (nonatomic, strong) IBOutlet UITextField *rent;
@property (nonatomic, strong) IBOutlet UILabel *expenses;
@property (nonatomic, strong) IBOutlet UILabel *roommateName;
@property (nonatomic, strong) IBOutlet UILabel *total;
@property (nonatomic, strong) IBOutlet UIImageView *profPic;
@property (nonatomic, strong) IBOutlet UIImageView *cellBackground;
@property (nonatomic, strong) id <GraphCellProtocol> delegate;

- (void)expenseLabelWasPressed:(id)sender;
- (void) setUpLabel;
@end
