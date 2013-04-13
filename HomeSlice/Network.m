//
//  Network.m
//  HomeSlice
//
//  Created by Jeremy Moyers on 2/27/13.
//  Copyright (c) 2013 Jeremy Moyers. All rights reserved.
//

#import "Network.h"
#import "constatns.h"

@implementation Network

+ (NSDictionary *) getPersonForUserId:(NSString *)userId
{
    NSError *error;
    
    NSString *url = [PERSON_URL stringByAppendingFormat:@"/%@", userId];
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
        
    }
    
    
    NSDictionary *userData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error];
    
    return userData;
}



//returns:
//$2 = 0x097e7850 {
//    createdAt = "2013-04-11T22:38:20.010Z";
//    objectId = smfGLNUdYE;
//    sessionToken = m3tzxuo1wuihmbwk3jtpc7c0b;
//}
+ (NSDictionary *) postObjectWithData:(NSDictionary *)postDict toURL:(NSString *)url
{
    NSError *error;
    NSData *postData = [NSJSONSerialization dataWithJSONObject:postDict options:NSJSONWritingPrettyPrinted error:&error];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    
    [request setURL:[NSURL URLWithString:url]];
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
            NSLog(@"Error posting object: %@", error.localizedDescription);
        }
    }
    
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableLeaves error:&err];
    
    return dict;
}

//returns:
//$3 = 0x0a36d6c0 {
//    createdAt = "2013-04-01T02:13:26.967Z";
//    objectId = ExZjvrA0X0;
//    "person_id" = bkoh4zUL7s;
//    sessionToken = nc1zppg0fi8lehrgz8i4768dp;
//    updatedAt = "2013-04-01T02:13:27.328Z";
//    username = "jmoyers14@gmail.com";
//}
+ (NSDictionary *) makeLoginGetRequestWithData:(NSDictionary *)getDict toURL:(NSString *)url
{
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    NSString *queryString = [self urlEncodeDictionary:getDict];
    [request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@?%@", url, queryString]]];
    [request addValue:HTTP_APPID forHTTPHeaderField:@"X-Parse-Application-Id"];
    [request addValue:HTTP_API_KEY forHTTPHeaderField:@"X-Parse-REST-API-Key"];
    [request setValue:HTTP_CONT_TYPE forHTTPHeaderField:@"Content-Type"];
    
    NSURLResponse *response;
    NSError *err;
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&err];
    
    if(responseData == nil)
    {
        if(err)
        {
            NSLog(@"Error posting object: %@", err.localizedDescription);
            return nil;
        }
    }
    
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableLeaves error:&err];
    
    return dict;
}



+ (NSArray *) makeGetRequestWithData:(NSDictionary *)getDict toURL:(NSString *)url
{
    //NSError *error;
    //NSData *getData = [NSJSONSerialization dataWithJSONObject:getDict options:NSJSONWritingPrettyPrinted error:&error];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    NSString *queryString = [self urlEncodeDictionary:getDict];
    [request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@?%@", url, queryString]]];
    [request addValue:HTTP_APPID forHTTPHeaderField:@"X-Parse-Application-Id"];
    [request addValue:HTTP_API_KEY forHTTPHeaderField:@"X-Parse-REST-API-Key"];
    [request setValue:HTTP_CONT_TYPE forHTTPHeaderField:@"Content-Type"];
    
    NSURLResponse *response;
    NSError *err;
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&err];
    
    if(responseData == nil)
    {
        if(err)
        {
            NSLog(@"Error posting object: %@", err.localizedDescription);
        }
    }
    
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableContainers error:&err];
    
    NSArray *array = [dict objectForKey:@"results"];
    return array;
}

// helper function: get the string form of any object
+ (NSString *) toString:(id) object
{
    return [NSString stringWithFormat: @"%@", object];
}

// helper function: get the url encoded string form of any object
+ (NSString *) urlEncode:(id) object
{
    NSString *string = [self toString:object];
    return [string stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding];
}

+ (NSString *) urlEncodeDictionary:(NSDictionary *)dict
{
    NSMutableArray *parts = [NSMutableArray array];
    for(id key in dict)
    {
        id value = [dict objectForKey: key];
        NSString *part = [NSString stringWithFormat:@"%@=%@", [self urlEncode:key], [self urlEncode:value]];
        [parts addObject:part];
    }
    return [parts componentsJoinedByString:@"&"];
}




@end
