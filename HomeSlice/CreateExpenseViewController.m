//
//  CreateExpenseViewController.m
//  HomeSlice
//
//  Created by Jeremy Moyers on 4/2/13.
//  Copyright (c) 2013 Jeremy Moyers. All rights reserved.
//

#import "CreateExpenseViewController.h"
#import "Singleton.h"
#import "FormHeaderCell.h"
#import "SubmitCell.h"

@interface CreateExpenseViewController ()

@end

@implementation CreateExpenseViewController
@synthesize actionSheet     = _actionSheet;
@synthesize dataSource = _dataSource;
@synthesize amount = _amount;
@synthesize name = _name;
@synthesize tView = _tView;
@synthesize floatAmount = _floatAmount;
@synthesize collectorName = _collectorName;
@synthesize collectorId = _collectorId;

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    
    self.actionSheet = [[UIActionSheet alloc] initWithTitle:nil
                                                             delegate:nil
                                                    cancelButtonTitle:nil
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:nil];
    
    [self.actionSheet setActionSheetStyle:UIActionSheetStyleBlackTranslucent];
    
    CGRect pickerFrame = CGRectMake(0, 40, 0, 0);
    
    UIPickerView *pickerView = [[UIPickerView alloc] initWithFrame:pickerFrame];
    pickerView.showsSelectionIndicator = YES;
    pickerView.dataSource = self;
    pickerView.delegate = self;
    
    [self.actionSheet addSubview:pickerView];
    
    UISegmentedControl *closeButton = [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObject:@"Close"]];
    closeButton.momentary = YES;
    closeButton.frame = CGRectMake(260, 7.0f, 50.0f, 30.0f);
    closeButton.segmentedControlStyle = UISegmentedControlStyleBar;
    closeButton.tintColor = [UIColor blackColor];
    [closeButton addTarget:self action:@selector(dismissActionSheet) forControlEvents:UIControlEventValueChanged];
    [self.actionSheet addSubview:closeButton];
    
    self.roommates = ((Singleton *)[Singleton sharedInstance]).roommates;

    for(Person *p in self.roommates)
        p.paymentHolder = @"0.00";
    
    self.dataSource = [[NSMutableArray alloc] init];
    [self.dataSource addObject:@"FillerForHeaderCell"];
    [self.dataSource addObjectsFromArray:self.roommates];
    [self.dataSource addObject:@"FillerForFooterCell"];
    self.name = [[NSString alloc] init];
    self.collectorName = ((Singleton *)[Singleton sharedInstance]).user.person.name;
    self.collectorId = ((Singleton *)[Singleton sharedInstance]).user.person.person_id;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)submit:(id)sender
{
    //add error checking on money values
    [self checkErrs];
    for(int i=1; i<self.dataSource.count-1;i++)
    {
        Person *p = (Person *)[self.dataSource objectAtIndex:i];
        Expense *e = [[Expense alloc] initWithPersonId:p.person_id collectorId:self.collectorId andAmount:p.paymentHolder andName:self.name];
        
        [p updateDataByAmount:e.amount.floatValue];
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (NSInteger)checkErrs
{
    NSString *expression = @"^([0-9]+)?(\\.([0-9]{1,2})?)?$";
    NSError *error = nil;
    
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:expression
                                                                           options:NSRegularExpressionCaseInsensitive
                                                                             error:&error];
    
    for(int i=1; i<self.dataSource.count-1;i++)
    {
        Person *p = (Person *)[self.dataSource objectAtIndex:i];
        NSUInteger numberOfMatches = [regex numberOfMatchesInString:p.paymentHolder
                                                        options:0
                                                          range:NSMakeRange(0, [p.paymentHolder length])];
        if (numberOfMatches == 0)
        {
            NSLog(@"invalid data here");
            return -1;
        }
    }
    
    NSLog(@"data is valid");
    return 1;
    
}

- (void)valueChange:(id)sender{
    UISwitch *s = (UISwitch *)sender;
    
    if([s isOn])
    {
        [self splitTheValue:self.amount];
    }
    else
    {
        [self setValuesToZero];
    }
}

- (void)splitTheValue:(NSString *)value
{
    self.floatAmount = [value floatValue];
    float evenAmount = self.floatAmount / self.roommates.count;
    
    for(int i=1; i<self.dataSource.count-1;i++)
    {
        Person *p = [self.dataSource objectAtIndex:i];
        p.paymentHolder = [NSString stringWithFormat:@"%3.2f", evenAmount];
    }
    
    [self.tView reloadData];
}

- (void)setValuesToZero
{
    for(int i=1; i<self.dataSource.count-1;i++)
    {
        Person *p = [self.dataSource objectAtIndex:i];
        p.paymentHolder = @"0.00";
    }
    
    [self.tView reloadData];
}

#pragma - mark ExpenseFaceCellDelegate

- (void)individualAmountChanged:(NSString *)amount atIndex:(NSInteger)index
{
    ((Person *)[self.dataSource objectAtIndex:index]).paymentHolder = amount;
}

#pragma - mark FormHeaderCellDelegate

-(void)updatedName:(NSString *)name
{
    self.name = name;
}

-(void)updatedAmount:(NSString *)amount withSplit:(BOOL)on
{
    self.amount = amount;
    
    if(on)
    {
        [self splitTheValue:amount];
    }
    else
    {
        NSLog(@"DONT DO THE SPLIT!");
    }
}

#pragma - mark UITableViewDelegate

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row == 0)
    {
        return 175;
    }
    else
    {
        return 80;
    }
}

#pragma - mark UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellIdentifier;
    if (indexPath.row == 0)
    {
        cellIdentifier = @"FormHeader";
        FormHeaderCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if(cell == nil)
        {
            cell = [[FormHeaderCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        }
        cell.collector.userInteractionEnabled = YES;
        UITapGestureRecognizer *tapGesture =
        [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(collectorWasPressed:)];
        [cell.collector addGestureRecognizer:tapGesture];
        cell.collector.text = self.collectorName;
        cell.delegate = self;
        [cell.splitSwitch addTarget:self action:@selector(valueChange:) forControlEvents:UIControlEventValueChanged];
        
        return cell;
    }
    else if(indexPath.row == self.dataSource.count-1)
    {
        cellIdentifier = @"SubmitCell";
        SubmitCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if(cell == nil)
        {
            cell = [[SubmitCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        }
        return cell;
    }
    else
    {
        cellIdentifier = @"FaceCell";
        ExpenseFaceCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if(cell == nil)
        {
            cell = [[ExpenseFaceCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        }
        Person *p = (Person *)[self.dataSource objectAtIndex:indexPath.row];
        cell.name.text = p.name;
        cell.amount.text = p.paymentHolder;
        cell.index = indexPath.row;
        cell.delegate = self;
        return cell;
    }
}

- (void)collectorWasPressed:(id)sender
{
        [self.actionSheet showInView:[[UIApplication sharedApplication] keyWindow]];
        [self.actionSheet setBounds:CGRectMake(0, 0, 320, 485)];
}




#pragma - mark UIPickerViewDelegate
- (void) pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    self.collectorName = ((Person *)[self.roommates objectAtIndex:row]).name;
    self.collectorId = ((Person *)[self.roommates objectAtIndex:row]).person_id;
    [self.tView reloadData];
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return self.roommates.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    
    return ((Person *)[self.roommates objectAtIndex:row]).name;
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (void) dismissActionSheet
{
    [self.actionSheet dismissWithClickedButtonIndex:0 animated:YES];

}

@end
