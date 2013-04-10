//
//  House.h
//  HomeSlice
//
//  Created by Jeremy Moyers on 3/3/13.
//  Copyright (c) 2013 Jeremy Moyers. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "constatns.h"
@interface House : NSObject

@property (nonatomic, strong) NSString *house_id;
@property (nonatomic, strong) NSString *house_name;
@property (nonatomic, strong) NSNumber *rent;


- (id) initWithDictionary:(NSDictionary *)dict;
- (id) initWithHouseId:(NSString*)houseId;

@end
