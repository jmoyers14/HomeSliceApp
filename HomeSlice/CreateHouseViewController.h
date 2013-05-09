//
//  CreateHouseViewController.h
//  HomeSlice
//
//  Created by Jeremy Moyers on 2/20/13.
//  Copyright (c) 2013 Jeremy Moyers. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomTextField.h"
#import "Parse/Parse.h"
#import "User.h"

@interface CreateHouseViewController : UIViewController <UITextFieldDelegate>


@property (nonatomic, strong) IBOutlet CustomTextField *houseName;
@property (nonatomic, strong) IBOutlet CustomTextField *houseKey;
@property (nonatomic, strong) IBOutlet CustomTextField *confirmHousePassword;
@property (nonatomic, strong) IBOutlet CustomTextField *rent;
@property (nonatomic, strong) User *user;


- (BOOL) createHouse;
@end
