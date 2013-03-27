//
//  Singleton.h
//  HomeSlice
//
//  Created by Jeremy Moyers on 2/27/13.
//  Copyright (c) 2013 Jeremy Moyers. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"
#import "Person.h"
#import "House.h"

@interface Singleton : NSObject

@property (nonatomic, strong) User *user;
@property (nonatomic, strong) House *house;

+(id)sharedInstance;



@end
