//
//  Post.m
//  HomeSlice
//
//  Created by Jeremy Moyers on 5/5/13.
//  Copyright (c) 2013 Jeremy Moyers. All rights reserved.
//

#import "Post.h"
#import "constatns.h"
@implementation Post
@synthesize objectId = _objectId;
@synthesize collectorId = _collectorId;
@synthesize houseId = _houseId;
@synthesize message = _message;
@synthesize payerId = _payerId;
@synthesize posterId = _posterId;
@synthesize type = _type;
@synthesize createdAt = _createdAt;
@synthesize stringDate = _stringDate;
- (id) initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    if (self)
    {
        self.type = [[dict objectForKey:@"type"] intValue];
        self.objectId = [dict objectForKey:@"objectId"];
        self.message = [dict objectForKey:@"message"];
        self.posterId = [dict objectForKey:@"poster_id"];
        self.houseId = [dict objectForKey:@"houes_id"];
        self.createdAt = (NSDate *)[dict objectForKey:@"createdAt"];
        self.stringDate = [dict objectForKey:@"createdAt"];
        if(!self.type == MESSAGE_TYPE)
        {
            self.collectorId = [dict objectForKey:@"collectorId"];
            self.payerId = [dict objectForKey:@"payer_id"];
        }
    }
    return self;
}

- (NSString *)formatTopLabel
{
    
    NSString *str = nil;
    if(self.type == MESSAGE_TYPE)
    {
        Person *p = [((Singleton *)[Singleton sharedInstance]).roommatesDict objectForKey:self.posterId];
        str = [NSString stringWithString:p.name];
    }
    else if (self.type == CHARGE_TYPE)
    {
        //tba
    }
    else if (self.type == PAYMENT_TYPE)
    {
        //tba
    }
    //random comment
    return str;
}

- (NSString *)formatDate
{
    
    NSArray* members = [self.stringDate componentsSeparatedByCharactersInSet: [NSCharacterSet characterSetWithCharactersInString: @"-T:"]];

    NSString *month = [members objectAtIndex:1];
    NSString *day = [members objectAtIndex:2];
    NSString *hour = [members objectAtIndex:3];
    NSString *minutes = [members objectAtIndex:4];
    
    NSString *formattedString = [NSString stringWithFormat:@"%@ %d at %d:%.2d", [self getMonth:[month intValue]], [day intValue], [hour intValue], [minutes intValue]];
    return formattedString;
}

- (NSString *) getMonth:(NSInteger)month
{
    switch (month) {
        case 1:
            return @"Jan";
            break;
        case 2:
            return @"Feb";
            break;
        case 3:
            return @"Mar";
            break;
        case 4:
            return @"Apr";
            break;
        case 5:
            return @"May";
            break;
        case 6:
            return @"Jun";
            break;
        case 7:
            return @"Jul";
            break;
        case 8:
            return @"Aug";
            break;
        case 9:
            return @"Sept";
            break;
        case 10:
            return @"Oct";
            break;
        case 11:
            return @"Nov";
            break;
        case 12:
            return @"Dec";
            break;
            
        default:
            return @"You broke the date";
            break;
    }
}

@end
