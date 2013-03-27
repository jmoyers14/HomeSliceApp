//
//  User.h
//  HomeSlice
//
//  Created by Jeremy Moyers on 2/27/13.
//  Copyright (c) 2013 Jeremy Moyers. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Person.h"
#import "constatns.h"
#import "House.h"

@interface User : NSObject

@property (nonatomic, strong) NSString *username;
@property (nonatomic, strong) Person *person;
@property (nonatomic, assign) BOOL loggedIn;
@property (nonatomic, strong) NSString *userId;
@property (nonatomic, strong) NSString *sessionToken;


- (BOOL) confirmPassword:(NSString*)password with:(NSString*)confPassword;
- (id)initWithDictionary:(NSDictionary *)dict;
- (id) initWithLoginDictionary:(NSDictionary *)dict;
- (NSDictionary *)registerUserWithPassword:(NSString *)password;
- (NSDictionary *)createRelationShipForUser:(NSString *)userId andPerson:(NSString *)personId;
- (NSDictionary *)loginWithUsername:(NSString *)username andPassword:(NSString *)password;
@end
