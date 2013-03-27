//
//  Utility.m
//  HomeSlice
//
//  Created by Jeremy Moyers on 3/5/13.
//  Copyright (c) 2013 Jeremy Moyers. All rights reserved.
//

#import "Utility.h"

@implementation Utility
@synthesize name = _name;
@synthesize provider = _provider;
@synthesize account_number = _account_number;
@synthesize phone_number = _phone_number;
@synthesize utility_id = _utility_id;
@synthesize utilityData = _utilityData;

- (id) initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    if(self)
    {
        self.name = [dict objectForKey:@"name"];
        self.provider = [dict objectForKey:@"provider"];
        self.account_number = [dict objectForKey:@"account_number"];
        self.phone_number = [dict objectForKey:@"phone_number"];
        self.utilityData = dict;
    }
    return self;
}

- (void) postUtility
{
    NSDictionary *resposeData;
    resposeData = [Network postObjectWithData:self.utilityData toURL:UTILITY_URL];
    self.utility_id = [resposeData objectForKey:@"objectId"];
    
}





@end
