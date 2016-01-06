//
//  BaseTableViewController.m
//  YUKit<https://github.com/c6357/YUKit>
//
//  Created by BruceYu on 15/3/20.
//  Copyright (c) 2015年 BruceYu. All rights reserved.
//

#import "BaseTableViewController.h"


@interface BaseTableViewController ()

@end

@implementation BaseTableViewController
- (void)dealloc
{
    self.cellDataList = nil;
}


- (void)awakeFromNib
{
    [self setup];    
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup
{
    self.currentPageIndex = self.startIndex = 1;
}

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.tableFooterView = [[UIView alloc]init];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}


- (void (^)())setupCellDataSuccessBlock:(UITableView *)tableView
{
    return ^(NSArray *dataList) {
        
        if (dataList && dataList.count > 0) {
            self.cellDataList = dataList;
             [self.tableView.footer resetNoMoreData];
            self.tableView.footer.hidden = NO;
        } else {
            self.cellDataList = @[];
            self.tableView.footer.hidden = YES;
        }
        
        
        [tableView reloadData];
        [self endRefreshing:tableView];

        self.currentPageIndex = self.startIndex;

        if (self.finishLoadData) {
            self.finishLoadData(tableView);
        }
    };
}

- (void (^)())setupCellDataFailureBlock:(UITableView *)tableView
{
    return ^(NSError *error) {
        [self endRefreshing:tableView];
        if (self.finishLoadData) {
            self.finishLoadData(tableView);
        }
    };
}

- (void (^)())addNewCellDataSuccessBlock:(UITableView *)tableView
{
    return ^(NSArray *dataList) {
        
        self.tableView.footer.hidden = NO;
        
        if (dataList && dataList.count > 0) {
                
            NSMutableArray *mArray = [NSMutableArray arrayWithArray:self.cellDataList];
            [mArray addObjectsFromArray:dataList];
            self.cellDataList = mArray;
            
            self.currentPageIndex++;
            [tableView reloadData];
        }else{
              [self.tableView.footer noticeNoMoreData];
        }
        
        [self endRefreshing:tableView];
        
        if (self.finishLoadData) {
            self.finishLoadData(tableView);
        }
    };
}

- (void (^)())addNewCellDataFailureBlock:(UITableView *)tableView
{
    return ^(NSError *error) {
        
        [self endRefreshing:tableView];
        if (self.finishLoadData) {
            self.finishLoadData(tableView);
        }
    };
}

- (void)endRefreshing:(UITableView *)tableView
{
    if (tableView.header.isRefreshing) {
        [tableView.header endRefreshing];
    }
    if (tableView.footer.isRefreshing) {
        [tableView.footer endRefreshing];
    }
    
}
@end
