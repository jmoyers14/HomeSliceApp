//
//  FormHeaderCell.m
//  HomeSlice
//
//  Created by Jeremy Moyers on 4/2/13.
//  Copyright (c) 2013 Jeremy Moyers. All rights reserved.
//

#import "FormHeaderCell.h"

@implementation FormHeaderCell

@synthesize staticCollector = _staticCollector;
@synthesize staticEven      = _staticEven;
@synthesize collector       = _collector;
@synthesize delegate        = _delegate;
@synthesize name            = _name;
@synthesize amount          = _amount;
@synthesize splitSwitch     = _splitSwitch;


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
//        self.collector.userInteractionEnabled = YES;
//        UITapGestureRecognizer *tapGesture =
//        [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(collectorSelected:)];
//        [self.collector addGestureRecognizer:tapGesture];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)collectorSelected:(id)sender
{
    NSLog(@"collector selected");
    //[self.delegate collectorWasPressed:self];
}


#pragma - mark UITextFieldDelegate

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if(textField == self.amount)
    {
        [self.delegate updatedAmount:self.amount.text withSplit:self.splitSwitch.isOn];
    }
    else
    {
        [self.delegate updatedName:self.name.text];
    }
}

- (BOOL) textFieldShouldReturn:(UITextField *)textField
{
    NSInteger nextTag = textField.tag + 1;
    
    UIResponder *nextResponder = [textField.superview viewWithTag:nextTag];
    
    if(nextResponder)
    {
        [nextResponder becomeFirstResponder];
        [self.delegate updatedName:self.name.text];
    }
    else if(textField == self.amount)
    {
        //[self.delegate doneWithKeyboard:self.amount];
        [self.delegate updatedAmount:self.amount.text withSplit:self.splitSwitch.isOn];
        [self.amount resignFirstResponder];
    }
    
    return NO;
}


@end
