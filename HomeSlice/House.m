//
//  House.m
//  HomeSlice
//
//  Created by Jeremy Moyers on 3/3/13.
//  Copyright (c) 2013 Jeremy Moyers. All rights reserved.
//

#import "House.h"

@implementation House
@synthesize house_id = _house_id;
@synthesize house_name = _house_name;
@synthesize rent = _rent;

- (id)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    if (self)
    {
        self.house_name = [dict objectForKey:@"name"];
        self.rent = [dict objectForKey:@"rent"];
        NSString *rentString = [self.rent stringValue];
        NSDictionary *houseData = [self postNewHouse:self.house_name withRent:rentString];
        self.house_id = [houseData objectForKey:@"objectId"];
    }
    return self;
}

- (id) initWithHouseId:(NSString*)houseId
{
    self = [super init];
    if(self)
    {
        self.house_id = houseId;
        self.house_name = @"well do this later";
    }
    return self;
}

-(NSDictionary *)postNewHouse:(NSString *)houseName withRent:(NSString *)rent
{
    
    NSMutableDictionary *postDict = [[NSMutableDictionary alloc] init];
    [postDict setObject:houseName forKey:@"name"];
    [postDict setObject:rent forKey:@"rent"];
    
    NSError *error;
    NSData *postData = [NSJSONSerialization dataWithJSONObject:postDict options:NSJSONWritingPrettyPrinted error:&error];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    
    [request setURL:[NSURL URLWithString:HOUSE_URL]];
    [request setHTTPMethod:@"POST"];
    [request addValue:HTTP_APPID forHTTPHeaderField:@"X-Parse-Application-Id"];
    [request addValue:HTTP_API_KEY forHTTPHeaderField:@"X-Parse-REST-API-Key"];
    [request setValue:HTTP_CONT_TYPE forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    
    NSURLResponse *response;
    NSError *err;
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&err];
    
    if(responseData == nil)
    {
        if(err)
        {
            NSLog(@"Error creating house: %@", error.localizedDescription);
        }
    }
    
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableLeaves error:&err];
    
    return dict;
}



@end
