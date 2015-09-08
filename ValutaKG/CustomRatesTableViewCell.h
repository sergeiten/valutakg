//
//  CustomRatesTableViewCell.h
//  valutakg
//
//  Created by Sergei Ten on 7/19/15.
//  Copyright (c) 2015 Sergei Ten. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomRatesTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *flag;
@property (weak, nonatomic) IBOutlet UILabel *currencyName;
@property (weak, nonatomic) IBOutlet UILabel *currencySell;
@property (weak, nonatomic) IBOutlet UILabel *currencyBuy;


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;



@end
