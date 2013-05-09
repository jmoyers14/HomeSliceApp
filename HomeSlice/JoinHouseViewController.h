//
//  JoinHouseViewController.h
//  HomeSlice
//
//  Created by Jeremy Moyers on 3/4/13.
//  Copyright (c) 2013 Jeremy Moyers. All righ3ts reserved.
//

#import <UIKit/UIKit.h>
#import "CustomTextField.h"
#import "Singleton.h"
#import "User.h"

@interface JoinHouseViewController : UIViewController <UITextFieldDelegate>
@property (nonatomic, strong) IBOutlet CustomTextField *houseName;
@property (nonatomic, strong) IBOutlet CustomTextField *houseKey;
@property (nonatomic, strong) IBOutlet UIActivityIndicatorView *spinner;
@property (nonatomic, strong) User *user;
@end
