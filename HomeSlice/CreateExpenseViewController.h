//
//  CreateExpenseViewController.h
//  HomeSlice
//
//  Created by Jeremy Moyers on 4/2/13.
//  Copyright (c) 2013 Jeremy Moyers. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FormHeaderCell.h"
#import "Person.h"
#import "Expense.h"
#import "ExpenseFaceCell.h"

@interface CreateExpenseViewController : UIViewController <UIPickerViewDataSource, UIPickerViewDelegate, UITableViewDataSource, UITableViewDelegate, FormHeaderCellDelegate, ExpenseFaceCellDelegate>



@property (nonatomic, strong) UIActionSheet *actionSheet;
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, strong) NSMutableArray *roommates;
@property (nonatomic, strong) NSString *amount;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *collectorName;
@property (nonatomic, strong) NSString *collectorId;
@property (nonatomic, strong) IBOutlet UITableView *tView;
@property (nonatomic, assign) float floatAmount;

-(void) dismissActionSheet;
-(IBAction)submit:(id)sender;
-(void)updatedName:(NSString *)name;
-(void)updatedAmount:(NSString *)amount withSplit:(BOOL)on;
-(void)valueChange:(id)sender;
-(void)splitTheValue:(NSString *)value;
-(void)setValuesToZero;
-(NSInteger)checkErrs;
@end
