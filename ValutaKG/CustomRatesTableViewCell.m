//
//  CustomRatesTableViewCell.m
//  valutakg
//
//  Created by Sergei Ten on 7/19/15.
//  Copyright (c) 2015 Sergei Ten. All rights reserved.
//

#import "CustomRatesTableViewCell.h"

@implementation CustomRatesTableViewCell



- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.contentView.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
    }
    return self;
}



@end
