//
//  Supply.h
//  HomeSlice
//
//  Created by Jeremy Moyers on 5/6/13.
//  Copyright (c) 2013 Jeremy Moyers. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Supply : NSObject
@property (nonatomic, strong) NSString *name;
@property (nonatomic, assign) BOOL inStock;
@property (nonatomic, strong) NSString *objectId;


- (id) initWithDictionary:(NSDictionary *)dict;
- (void) setSupplyStock:(BOOL)stock;

@end
