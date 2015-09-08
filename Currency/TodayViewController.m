//
//  TodayViewController.m
//  Currency
//
//  Created by Sergei Ten on 8/25/15.
//  Copyright (c) 2015 Sergei Ten. All rights reserved.
//

#import "TodayViewController.h"
#import "Currency.h"
#import "NetworkService.h"
#import "CustomRatesTableViewCell.h"
#import <NotificationCenter/NotificationCenter.h>

@interface TodayViewController () <NCWidgetProviding>

@property (strong, nonatomic) NSMutableArray *currencies;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation TodayViewController

- (NSMutableArray *)currencies {
    if (!_currencies) {
        _currencies = [NSMutableArray array];
    }
    
    return _currencies;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadCurrency];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)widgetPerformUpdateWithCompletionHandler:(void (^)(NCUpdateResult))completionHandler {
    // Perform any setup necessary in order to update the view.
    
    // If an error is encountered, use NCUpdateResultFailed
    // If there's no update required, use NCUpdateResultNoData
    // If there's an update, use NCUpdateResultNewData
    
    completionHandler(NCUpdateResultNewData);
}

- (UIEdgeInsets)widgetMarginInsetsForProposedMarginInsets:(UIEdgeInsets)margins
{
    margins.bottom = 10.0;
    
    return margins;
}

- (void)loadCurrency {
    [[NetworkService sharedNetworkService] currentRatessuccess:^(NSArray *currencies){
        
        [self.currencies addObjectsFromArray:currencies];
        
        [self.tableView reloadData];
        
//        self.preferredContentSize = self.tableView.contentSize;
    } failure:^(NSError *error, NSInteger statusCode) {
        NSLog(@"%@", error);
    }];
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.currencies count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"ratesCell";
    
    CustomRatesTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell) {
        cell = [[CustomRatesTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    Currency *currency = [self.currencies objectAtIndex:indexPath.row];
    
    UIImage *flag = [UIImage imageNamed:currency.currencyFlag];
    
    [cell.flag setImage:flag];
    
    cell.currencyName.text = currency.currencyLabel;
    cell.currencyBuy.text = currency.rateBuy;
    cell.currencySell.text = currency.rateSell;
    
    return cell;
}

@end
