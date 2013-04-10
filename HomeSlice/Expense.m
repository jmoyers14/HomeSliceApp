//
//  Expense.m
//  HomeSlice
//
//  Created by Jeremy Moyers on 4/3/13.
//  Copyright (c) 2013 Jeremy Moyers. All rights reserved.
//

#import "Expense.h"
#import "constatns.h"

@implementation Expense
@synthesize collectorId = _collectorId;
@synthesize collectorName = _collectorName;
@synthesize personId = _personId;
@synthesize amount = _amount;
@synthesize objectId = _objectId;
@synthesize name = _name;

- (id) initWithPersonId:(NSString *)personId collectorId:(NSString *)collecterId andAmount:(NSString *)amount andName:(NSString *)name
{
    self = [super init];
    if(self)
    {
        self.collectorId = collecterId;
        self.personId = personId;
        self.amount = amount;
        self.name = name;
        NSDictionary *dict = [self postExpense];
    }
    return self;
}

- (id) initWithDict:(NSDictionary *)dict
{
    self = [super init];
    if(self)
    {
        self.collectorId = [dict objectForKey:@"collector_id"];
        self.personId    = [dict objectForKey:@"person_id"];
        self.amount      = [dict objectForKey:@"amount"];
        self.name        = [dict objectForKey:@"name"];
    }
    return self;
}


- (NSDictionary *) postExpense
{
    NSMutableDictionary *postDict = [[NSMutableDictionary alloc] init];
    [postDict setObject:self.personId forKey:@"person_id"];
    [postDict setObject:self.collectorId forKey:@"collector_id"];
    [postDict setObject:self.amount forKey:@"amount"];
    [postDict setObject:self.name forKey:@"name"];
    
    NSError *error;
    NSData *postData = [NSJSONSerialization dataWithJSONObject:postDict options:NSJSONWritingPrettyPrinted error:&error];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    
    [request setURL:[NSURL URLWithString:EXPENSE_URL]];
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


@end
