//
//  User.m
//  HomeSlice
//
//  Created by Jeremy Moyers on 2/27/13.
//  Copyright (c) 2013 Jeremy Moyers. All rights reserved.
//

#import "User.h"

@implementation User
@synthesize username = _username;
@synthesize person = _property;
@synthesize loggedIn = _loggedIn;
@synthesize userId = _userId;
@synthesize sessionToken = _sessionToken;



-(id) initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    if(self)
    {
        NSDictionary *userData;
        self.username = [dict objectForKey:@"username"];
        self.loggedIn = NO;
        userData      = [self registerUserWithPassword:[dict objectForKey:@"password"]];
        
        if(self.loggedIn == YES)
        {
            self.userId   = [userData objectForKey:@"objectId"];
            self.sessionToken = [userData objectForKey:@"sessionToken"];
            self.person   = [[Person alloc] initWithName:[dict objectForKey:@"fullName"]];
            [self createRelationShipForUser:self.userId andPerson:self.person.person_id];
        }
        
    }
    return self;
}


/*
 *Init returning user
 */
-(id) initWithLoginDictionary:(NSDictionary *)dict
{
    self = [super init];
    if(self)
    {
        NSDictionary *userData;
        self.username = [dict objectForKey:@"username"];
        self.loggedIn = NO;
        userData = [Network makeLoginGetRequestWithData:dict toURL:LOGIN_URL];
        self.loggedIn = YES;
        
        if(self.loggedIn == YES)
        {
            self.userId   = [userData objectForKey:@"objectId"];
            self.sessionToken = [userData objectForKey:@"sessionToken"];
            self.person = [[Person alloc] initWithPersonId:[userData objectForKey:@"person_id"]];
        }
    }
    return self;
}

-(BOOL) confirmPassword:(NSString*)password with:(NSString*)confPassword
{
    if([password isEqualToString:confPassword])
        return YES;
    else
        return NO;
}


- (NSDictionary *)loginWithUsername:(NSString *)username andPassword:(NSString *)password
{
    NSError *error;
    
    NSString *url = [LOGIN_URL stringByAppendingFormat:@"?username=%@&password=%@", username, password];
    NSURL *buildURL = [NSURL URLWithString:url];
    
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:buildURL cachePolicy:NSURLRequestReloadRevalidatingCacheData timeoutInterval:200.0];
    
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:&error];
    
    
    if(data == nil)
    {
        if(error)
        {
            NSLog(@"Error loggin in user: %@", error.localizedDescription);
        }
    }
    else
    {
        self.loggedIn = YES;
    }
    
    
    NSDictionary *userData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error];
    
    return userData;
}


- (NSDictionary *)createRelationShipForUser:(NSString *)userId andPerson:(NSString *)personId
{
    NSMutableDictionary *putDict = [[NSMutableDictionary alloc] init];
    [putDict setObject:personId forKey:@"person_id"];
    
    NSError *error;
    NSData *putData = [NSJSONSerialization dataWithJSONObject:putDict
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:&error];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    NSString *url = [NSString stringWithFormat:@"%@/%@", USERS_URL, userId];
    [request setURL:[NSURL URLWithString: url]];
    
    [request setHTTPMethod:@"PUT"];
    [request addValue:HTTP_APPID forHTTPHeaderField:@"X-Parse-Application-Id"];
    [request addValue:HTTP_API_KEY forHTTPHeaderField:@"X-Parse-REST-API-Key"];
    [request setValue:HTTP_CONT_TYPE forHTTPHeaderField:@"Content-Type"];
    [request setValue:self.sessionToken forHTTPHeaderField:@"X-Parse-Session-Token"];
    [request setHTTPBody:putData];
    
    NSURLResponse *response;
    NSError *err;
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&err];
    
    
    if(responseData == nil)
    {
        if(err)
        {
            NSLog(@"Error setting user and person relation: %@", error.localizedDescription);
        }
    }
    else
    {
        
    }
    
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableLeaves error:&err];
    
    return dict;
}

- (NSDictionary *)registerUserWithPassword:(NSString *)password
{

    NSMutableDictionary *postDict = [[NSMutableDictionary alloc] init];
    [postDict setObject:self.username forKey:@"username"];
    [postDict setObject:password forKey:@"password"];
    
    NSError *error;
    NSData *postData = [NSJSONSerialization dataWithJSONObject:postDict
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:&error];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString: USERS_URL]];
    
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
    else
    {
        self.loggedIn = YES;
    }
    
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableLeaves error:&err];
    
    return dict;
}

@end
