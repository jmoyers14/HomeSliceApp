//
//  Person.m
//  HomeSlice
//
//  Created by Jeremy Moyers on 2/27/13.
//  Copyright (c) 2013 Jeremy Moyers. All rights reserved.
//

#import "Person.h"
#import "constatns.h"

@implementation Person
@synthesize person_id = _person_id;
@synthesize rent = _rent;
@synthesize name = _name;
@synthesize house = _house;


-(id) initWithDictionary:(NSDictionary*) dict
{
    self = [super init];
    if (self)
    {
        
    }
    return self;
}

-(id) initWithName:(NSString *)fullName
{
    self = [super init];
    if (self)
    {
        NSDictionary *dict;
        dict = [self postNewPerson:fullName];
        self.person_id = [dict objectForKey:@"objectId"];
    }
    return self;
}

-(id) initWithPersonId:(NSString *)personId
{
    self = [super init];
    if(self)
    {
        NSDictionary *personData;
        NSMutableDictionary *queryData = [[NSMutableDictionary alloc] init];
        NSArray *personArray;
        
        [queryData setObject:personId forKey:@"objectId"];
        
        personArray = [Network makeGetRequestWithData:queryData toURL:PERSON_URL];
        personData = [personArray objectAtIndex:0];
        self.person_id = [personData objectForKey:@"objectId"];
        self.name = [personData objectForKey:@"name"];
        self.rent = [NSNumber numberWithFloat:[[personData objectForKey:@"rent"] floatValue]];
        self.house.house_id = [personData objectForKey:@"house_id"];
    }
    return self;
}

-(NSDictionary *)postNewPerson:(NSString *)fullName
{
    
    NSMutableDictionary *postDict = [[NSMutableDictionary alloc] init];
    [postDict setObject:fullName forKey:@"name"];
    
    NSError *error;
    NSData *postData = [NSJSONSerialization dataWithJSONObject:postDict options:NSJSONWritingPrettyPrinted error:&error];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    
    [request setURL:[NSURL URLWithString:PERSON_URL]];
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
            NSLog(@"Error registering user: %@", error.localizedDescription);
        }
    }
    
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableLeaves error:&err];
    
    return dict;
}

- (void)createHouseNamed:(NSString *)name withRent:(NSNumber *)rent
{
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    [dict setObject:name forKey:@"name"];
    [dict setObject:rent forKey:@"rent"];
    NSDictionary *returnData = [Network postObjectWithData:dict toURL:HOUSE_URL];
    
    [self createRelationshipForPersonWithHouse:[returnData objectForKey:@"objectId"]];
}

- (NSDictionary *) createRelationshipForPersonWithHouse:(NSString *)houseId
{
    NSMutableDictionary *putDict = [[NSMutableDictionary alloc] init];
    [putDict setObject:houseId forKey:@"house_id"];
    
    NSError *error;
    NSData *putData = [NSJSONSerialization dataWithJSONObject:putDict
                                                      options:NSJSONWritingPrettyPrinted
                                                        error:&error];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    NSString *url = [NSString stringWithFormat:@"%@/%@", PERSON_URL, self.person_id];
    [request setURL:[NSURL URLWithString: url]];
    
    [request setHTTPMethod:@"PUT"];
    [request addValue:HTTP_APPID forHTTPHeaderField:@"X-Parse-Application-Id"];
    [request addValue:HTTP_API_KEY forHTTPHeaderField:@"X-Parse-REST-API-Key"];
    [request setValue:HTTP_CONT_TYPE forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:putData];
    
    NSURLResponse *response;
    NSError *err;
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&err];
    
    
    if(responseData == nil)
    {
        if(err)
        {
            NSLog(@"Error setting person house relation: %@", error.localizedDescription);
        }
    }
    else
    {
        
    }
    
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableLeaves error:&err];
    return dict;
}

- (void) joinHouseWithName:(NSString *)name
{
    NSMutableDictionary *houseDict = [[NSMutableDictionary alloc] init];
    [houseDict setObject:name forKey:@"name"];
    NSArray *returnArray = [Network makeGetRequestWithData:houseDict toURL:HOUSE_URL];
    NSDictionary *returnData = [returnArray objectAtIndex:0];
    NSString *houseId = [returnData objectForKey:@"objectId"];
    [self createRelationshipForPersonWithHouse:houseId];
}

@end
