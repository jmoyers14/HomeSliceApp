//
//  Post.h
//  HomeSlice
//
//  Created by Jeremy Moyers on 5/5/13.
//  Copyright (c) 2013 Jeremy Moyers. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Person.h"
#import "Singleton.h"
@interface Post : NSObject

@property (nonatomic, strong) NSString *objectId;
@property (nonatomic, strong) NSString *collectorId;
@property (nonatomic, strong) NSString *houseId;
@property (nonatomic, strong) NSString *message;
@property (nonatomic, strong) NSString *payerId;
@property (nonatomic, strong) NSString *posterId;
@property (nonatomic, assign) NSInteger type;
@property (nonatomic, assign) NSDate *createdAt;
@property (nonatomic, strong) NSString *stringDate;
- (id) initWithDictionary:(NSDictionary *)dict;
- (NSString *)formatTopLabel;
- (NSString *)formatDate;
@end
