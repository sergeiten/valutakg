//
//  CurrentRatesTableViewController.m
//  valutakg
//
//  Created by Sergei Ten on 7/19/15.
//  Copyright (c) 2015 Sergei Ten. All rights reserved.
//

#import "CurrentRatesTableViewController.h"
#import "CustomRatesTableViewCell.h"
#import "NetworkService.h"
#import "Currency.h"

@interface CurrentRatesTableViewController ()

@property (strong, nonatomic) NSMutableArray *currencies;
@property (strong, nonatomic) UIView *activityView;


@end

@implementation CurrentRatesTableViewController

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

- (NSMutableArray *)currencies {
    if (!_currencies) {
        _currencies = [NSMutableArray array];
    }
    
    return _currencies;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.titleView = [[UIImageView  alloc] initWithImage:[UIImage imageNamed:@"logo-alt"]];
    
    // remove cell lines
//    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    // hide empty cells
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    [self showActivityIndicator];
    
    // load currency rates
    [self loadCurrency];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Methods
- (IBAction)refreshCurrencyRates:(id)sender {
    self.currencies = [NSMutableArray array];
    
    [self showActivityIndicator];
    [self loadCurrency];
}

- (void)loadCurrency {
    [[NetworkService sharedNetworkService] currentRatessuccess:^(NSArray *currencies){
        
        [self.currencies addObjectsFromArray:currencies];
        
        [self.tableView reloadData];
        
        [self hideActivityIndicator];
    } failure:^(NSError *error, NSInteger statusCode) {

    }];
}

#pragma mark - Table view data source

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
    
    if (indexPath.row % 2) {
        cell.backgroundColor = [UIColor colorWithRed:245.0/255.0 green:245.0/255.0 blue:245.0/255.0 alpha:1];
    }

    
    return cell;
}

- (void)viewDidLayoutSubviews {
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.tableView setLayoutMargins:UIEdgeInsetsZero];
    }
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}

#pragma mark - Activity Indicator
- (void)showActivityIndicator {
    UIWindow *window = [[UIApplication sharedApplication] delegate].window;
    
    CGFloat navigationBarHeight = self.navigationController.navigationBar.frame.size.height;
    CGFloat statusBarHeight = [UIApplication sharedApplication].statusBarFrame.size.height;
    CGFloat navigationAndStatusBarHeight = navigationBarHeight + statusBarHeight;
    
    self.activityView = [[UIView alloc] initWithFrame:CGRectMake(0, navigationAndStatusBarHeight, window.bounds.size.width, window.bounds.size.height)];
    self.activityView.backgroundColor = [UIColor whiteColor];
    
    UIActivityIndicatorView *activityWheel = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(window.bounds.size.width / 2 - 12, window.bounds.size.height / 2 - 12 - navigationAndStatusBarHeight, 24, 24)];
    
    activityWheel.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
    activityWheel.autoresizingMask = (UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleBottomMargin);
    
    [self.activityView addSubview:activityWheel];
    [window addSubview:self.activityView];
    
    [[[self.activityView subviews] objectAtIndex:0] startAnimating];
}

- (void)hideActivityIndicator {
    [[[self.activityView subviews] objectAtIndex:0] stopAnimating];
    [self.activityView removeFromSuperview];
    self.activityView = nil;
}

@end
