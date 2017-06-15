//
//  BaseTableViewController.h
//  YUKit<https://github.com/c6357/YUKit>
//
//  Created by BruceYu on 15/3/20.
//  Copyright (c) 2015年 BruceYu. All rights reserved.
//


#import <UIKit/UIKit.h>
#import <MJRefresh/MJRefresh.h>
#import "BaseViewController.h"
#import "UITableView+BaseClass.h"

@interface BaseTableViewController : BaseViewController

@property (strong, nonatomic) NSArray *cellDataList;
@property (strong, nonatomic) UITableView *tableView;

// default is 1 n
@property (assign, nonatomic) NSUInteger startIndex;
@property (assign, nonatomic) NSUInteger currentPageIndex;

@property (copy, nonatomic) void(^finishLoadData)(UITableView *tableView);
@property (copy, nonatomic) void(^endRefreshingBlock)(UITableView *tableView);


// 初始化celldata成功
- (void (^)())setupCellDataSuccessBlock:(UITableView *)tableView;
// 获得celldata失败
- (void (^)())setupCellDataFailureBlock:(UITableView *)tableView;

// 获得新增celldata 成功
- (void (^)())addNewCellDataSuccessBlock:(UITableView *)tableView;
// 获得新增celldata失败
- (void (^)())addNewCellDataFailureBlock:(UITableView *)tableView;


@end
