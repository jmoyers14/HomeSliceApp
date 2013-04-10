//
//  ExpenseFaceCell.m
//  HomeSlice
//
//  Created by Jeremy Moyers on 4/2/13.
//  Copyright (c) 2013 Jeremy Moyers. All rights reserved.
//

#import "ExpenseFaceCell.h"

@implementation ExpenseFaceCell

@synthesize pic  = _pic;
@synthesize name = _name;
@synthesize amount = _amount;
@synthesize index = _index;

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


#pragma - mark UITextFieldDelegate

- (BOOL) textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return NO;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [self.delegate individualAmountChanged:textField.text atIndex:self.index];
}

@end
