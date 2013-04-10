//
//  ExpenseFaceCell.h
//  HomeSlice
//
//  Created by Jeremy Moyers on 4/2/13.
//  Copyright (c) 2013 Jeremy Moyers. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol ExpenseFaceCellDelegate <NSObject>

@required
- (void) individualAmountChanged:(NSString *)amount atIndex:(NSInteger)index;
@end


@interface ExpenseFaceCell : UITableViewCell <UITextFieldDelegate>

@property (nonatomic, assign) NSInteger index;
@property (nonatomic, strong) IBOutlet UIImageView *pic;
@property (nonatomic, strong) IBOutlet UILabel *name;
@property (nonatomic, strong) IBOutlet UITextField *amount;
@property (nonatomic, strong) id <ExpenseFaceCellDelegate> delegate;
@end
