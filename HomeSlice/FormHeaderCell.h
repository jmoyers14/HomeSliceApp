//
//  FormHeaderCell.h
//  HomeSlice
//
//  Created by Jeremy Moyers on 4/2/13.
//  Copyright (c) 2013 Jeremy Moyers. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol FormHeaderCellDelegate <NSObject>

@required
-(void)updatedName:(NSString *)name;
-(void)updatedAmount:(NSString *)amount withSplit:(BOOL)on;
//-(void)collectorWasPressed:(id)sender;
//-(void)doneWithKeyboard:(id)sender;
@end

@interface FormHeaderCell : UITableViewCell 
@property (nonatomic, strong) IBOutlet UILabel *staticCollector;
@property (nonatomic, strong) IBOutlet UILabel *staticEven;
@property (nonatomic, strong) IBOutlet UILabel *collector;
@property (nonatomic, strong) IBOutlet UISwitch *splitSwitch;
@property (nonatomic, strong) id <FormHeaderCellDelegate> delegate;


@property (nonatomic, strong) IBOutlet UITextField *name;
@property (nonatomic, strong) IBOutlet UITextField *amount;

- (IBAction)collectorSelected:(id)sender;

@end
