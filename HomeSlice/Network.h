//
//  Network.h
//  HomeSlice
//
//  Created by Jeremy Moyers on 2/27/13.
//  Copyright (c) 2013 Jeremy Moyers. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface Network : NSObject


+ (NSDictionary *) getPersonForUserId:(NSString *)userId;

+ (NSDictionary *) postObjectWithData:(NSDictionary *)postDict toURL:(NSString *)url;
+ (NSArray *) makeGetRequestWithData:(NSDictionary *)getDict toURL:(NSString *)url;
+ (NSString *) urlEncodeDictionary:(NSDictionary *)dict;
+ (NSString *) toString:(id)object;
+ (NSString *)urlEncode:(id)object;
+ (NSDictionary *) makeLoginGetRequestWithData:(NSDictionary *)getDict toURL:(NSString *)url;
+ (NSArray *) makeGetRequestForPosts:(NSDictionary *)getDict toURL:(NSString *)url;
+ (NSDictionary *) updateObjectWithId:(NSString *)objectId withData:(NSDictionary *)putDict toURL:(NSString*)urlString;
@end
