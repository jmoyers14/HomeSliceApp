//
//  Utility.h
//  HomeSlice
//
//  Created by Jeremy Moyers on 3/5/13.
//  Copyright (c) 2013 Jeremy Moyers. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Network.h"
#import "constatns.h"

@interface Utility : NSObject
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *provider;
@property (nonatomic, strong) NSString *account_number;
@property (nonatomic, strong) NSString *phone_number;
@property (nonatomic, strong) NSString *utility_id;
@property (nonatomic, strong) NSDictionary *utilityData;

- (id) initWithDictionary:(NSDictionary *)dict;
- (void) postUtility;
@end
