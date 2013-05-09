//
//  SupplyCell.m
//  HomeSlice
//
//  Created by Jeremy Moyers on 5/6/13.
//  Copyright (c) 2013 Jeremy Moyers. All rights reserved.
//

#import "SupplyCell.h"

@implementation SupplyCell
@synthesize banner = _banner;
@synthesize supplyName = _supplyName;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
