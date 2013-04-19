//
//  GraphCell.m
//  HomeSlice
//
//  Created by Jeremy Moyers on 3/31/13.
//  Copyright (c) 2013 Jeremy Moyers. All rights reserved.
//

#import "GraphCell.h"

@implementation GraphCell

@synthesize rent = _rent;
@synthesize expenses = _expenses;
@synthesize roommateName = _roommateName;
@synthesize total = _total;
@synthesize profPic = _profPic;
@synthesize cellBackground = _cellBackground;
@synthesize index = _index;
@synthesize delegate = _delegate;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
                        
- (void) setUpLabel
{
    UITapGestureRecognizer *tapGesture =
    [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(expenseLabelWasPressed:)];
    [self.expenses addGestureRecognizer:tapGesture];
    float totes = [self.rent.text floatValue] + [self.expenses.text floatValue];
    self.total.text = [NSString stringWithFormat:@"%3.2f", totes];
}

- (void)expenseLabelWasPressed:(id)sender
{
    [self.delegate showExpensesFor:self.index];
}

#pragma - mark UITextFieldDelegate

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    NSLog(@"dis been called");
    if(textField == self.rent)
    {
        [self.delegate updateRentForPerson:self.index byAmount:[self.rent.text floatValue]];
        float totes = [self.rent.text floatValue] + [self.expenses.text floatValue];
        self.total.text = [NSString stringWithFormat:@"%3.2f", totes];

    }
}

- (BOOL) textFieldShouldReturn:(UITextField *)textField
{
    [self.rent resignFirstResponder];
    return NO;
}
@end
