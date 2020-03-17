//
//  BaseChildTableViewController.m
//  IrishRailLive
//
//  Created by Borislav Georgiev on 3/17/2020.
//  Copyright © 2020 BGeorgiev. All rights reserved.
//

#import "BaseChildTableViewController.h"

@interface BaseChildTableViewController ()

@end

@implementation BaseChildTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    
    __weak typeof(self) weakSelf = self;
    [self setTabBarVisible:NO animated:animated animations:^(CGFloat offsetY) {
        weakSelf.tableViewBottomConstraint.constant = -offsetY;
        
        UIEdgeInsets contentInset = weakSelf.tableView.contentInset;
        contentInset.bottom -= offsetY;
        weakSelf.tableView.contentInset = contentInset;
        
        UIEdgeInsets scrollIndicatorInsets = weakSelf.tableView.scrollIndicatorInsets;
        scrollIndicatorInsets.bottom -= offsetY;
        weakSelf.tableView.scrollIndicatorInsets = scrollIndicatorInsets;
    } completion:nil];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    __weak typeof(self) weakSelf = self;
    [self setTabBarVisible:YES animated:animated animations:^(CGFloat offsetY) {
        weakSelf.tableViewBottomConstraint.constant = 0;
        
        UIEdgeInsets contentInset = weakSelf.tableView.contentInset;
        contentInset.bottom = 0;
        weakSelf.tableView.contentInset = contentInset;
        
        UIEdgeInsets scrollIndicatorInsets = weakSelf.tableView.scrollIndicatorInsets;
        scrollIndicatorInsets.bottom = 0;
        weakSelf.tableView.scrollIndicatorInsets = scrollIndicatorInsets;
    } completion:nil];
}

@end
