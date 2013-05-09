
//
//  Supply.m
//  HomeSlice
//
//  Created by Jeremy Moyers on 5/6/13.
//  Copyright (c) 2013 Jeremy Moyers. All rights reserved.
//

#import "Supply.h"

@implementation Supply
@synthesize name = _name;
@synthesize inStock = _inStock;
@synthesize objectId = _objectId;


- (id) initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    if(self)
    {
        self.name    = [dict objectForKey:@"name"];
        self.inStock = [[dict objectForKey:@"stocked"] boolValue];
        self.objectId = [dict objectForKey:@"objectId"];
    }
    return self;
}

- (void) setSupplyStock:(BOOL)stock
{
    
}


@end
