//
//  NewPostViewController.h
//  HomeSlice
//
//  Created by Jeremy Moyers on 4/25/13.
//  Copyright (c) 2013 Jeremy Moyers. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Singleton.h"
 #import <QuartzCore/QuartzCore.h>
@interface NewPostViewController : UIViewController

@property (nonatomic, strong) IBOutlet UITextView *textView;
@property (nonatomic, strong) IBOutlet UIView *keyboardToolbar;
@property (nonatomic, strong) IBOutlet UIActivityIndicatorView *spinner;

- (IBAction)postMessage:(id)sender;
- (IBAction)hideKeyboard:(id)sender;

@end
