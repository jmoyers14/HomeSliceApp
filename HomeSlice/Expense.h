//
//  Expense.h
//  HomeSlice
//
//  Created by Jeremy Moyers on 4/3/13.
//  Copyright (c) 2013 Jeremy Moyers. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Expense : NSObject

@property (nonatomic, strong) NSString *objectId;
@property (nonatomic, strong) NSString *collectorId;
@property (nonatomic, strong) NSString *collectorName;
@property (nonatomic, strong) NSString *personId;
@property (nonatomic, strong) NSString *amount;
@property (nonatomic, strong) NSString *name;

- (id) initWithPersonId:(NSString *)personId collectorId:(NSString *)collecterId andAmount:(NSString *)amount andName:(NSString *)name;

- (id) initWithDict:(NSDictionary *)dict;

- (NSDictionary *) postExpense;
@end
