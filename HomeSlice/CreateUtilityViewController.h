//
//  CreateUtilityViewController.h
//  HomeSlice
//
//  Created by Jeremy Moyers on 3/5/13.
//  Copyright (c) 2013 Jeremy Moyers. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomTextField.h"
#import "Utility.h"

@interface CreateUtilityViewController : UIViewController <UITextFieldDelegate>

@property (nonatomic, strong) IBOutlet CustomTextField *accountNumber;
@property (nonatomic, strong) IBOutlet CustomTextField *name;
@property (nonatomic, strong) IBOutlet CustomTextField *website;
@property (nonatomic, strong) IBOutlet CustomTextField *provider;
@property (nonatomic, strong) Utility *utility;

- (IBAction)createNewUtility:(id)sender;

@end
