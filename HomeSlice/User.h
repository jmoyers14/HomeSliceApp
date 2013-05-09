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
#import "FacebookSDK/FacebookSDK.h"

@interface User : NSObject

@property (nonatomic, strong) NSString *username;
@property (nonatomic, strong) Person *person;
@property (nonatomic, assign) BOOL loggedIn;
@property (nonatomic, strong) NSString *userId;
@property (nonatomic, strong) NSString *sessionToken;


- (BOOL) confirmPassword:(NSString*)password with:(NSString*)confPassword;
- (id)initAfterSignup:(NSDictionary *)dict;
- (id) initWithLoginDictionary:(NSDictionary *)dict;
- (id) initAfterLogin:(NSDictionary *)dict;

- (id) initAfterFbLogin:(NSDictionary<FBGraphUser>*) user withData:(NSDictionary *)dict;
- (id) initAfterFbSignup:(NSDictionary<FBGraphUser>*) user withDAta:(NSDictionary *)dict;

- (NSDictionary *)registerUserWithPassword:(NSString *)password;
- (NSDictionary *)createRelationShipForUser:(NSString *)userId andPerson:(NSString *)personId;
- (NSDictionary *)loginWithUsername:(NSString *)username andPassword:(NSString *)password;
@end
