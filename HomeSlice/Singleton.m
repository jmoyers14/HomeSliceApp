//
//  Singleton.m
//  HomeSlice
//
//  Created by Jeremy Moyers on 2/27/13.
//  Copyright (c) 2013 Jeremy Moyers. All rights reserved.
//

#import "Singleton.h"

@implementation Singleton
@synthesize user = _user;
static Singleton *sharedInstance = nil;

+ (Singleton *)sharedInstance
{
    if(nil != sharedInstance)
    {
        return sharedInstance;
    }
    
    static dispatch_once_t pred;
    dispatch_once(&pred, ^{
        sharedInstance = [[Singleton alloc] init];
    });
    
    return sharedInstance;
}

- (id) init
{
    self = [super init];
    
    if(self)
    {
        
    }
    return self;
}



@end
