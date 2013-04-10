//
//  Person.h
//  HomeSlice
//
//  Created by Jeremy Moyers on 2/27/13.
//  Copyright (c) 2013 Jeremy Moyers. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Network.h"
#import "House.h"

@interface Person : NSObject
@property (nonatomic, strong) NSString *person_id;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSNumber *rent;
@property (nonatomic, strong) House *house;
@property (nonatomic, strong) NSString *paymentHolder;
@property (nonatomic, assign) float debt;

- (id) initWithDictionary:(NSDictionary*) dict;
- (NSDictionary *)postNewPerson:(NSString *)fullName;
- (id) initWithName:(NSString *)fullName;
- (id) initWithPersonId:(NSString *)personId;
- (void) createHouseNamed:(NSString *)name withRent:(NSNumber *)rent;
- (NSDictionary *) createRelationshipForPersonWithHouse:(NSString *)houseId;
- (void) joinHouseWithName:(NSString *)name;
- (NSDictionary *)updateDataByAmount:(float)amount;
- (NSDictionary *)updateRentToAmount:(float)amount;

@end
