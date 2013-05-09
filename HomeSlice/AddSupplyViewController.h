//
//  AddSupplyViewController.h
//  HomeSlice
//
//  Created by Jeremy Moyers on 5/6/13.
//  Copyright (c) 2013 Jeremy Moyers. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddSupplyViewController : UIViewController <UITextFieldDelegate>

@property (nonatomic, strong) IBOutlet UITextField *supplyName;
@property (nonatomic, strong) IBOutlet UIActivityIndicatorView *spinner;
@end
