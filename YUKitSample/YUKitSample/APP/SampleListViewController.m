//
//       \\     //    ========     \\    //
//        \\   //          ==       \\  //
//         \\ //         ==          \\//
//          ||          ==           //\\
//          ||        ==            //  \\
//          ||       ========      //    \\
//
//  SampleListViewController.m
//  YUKit
//
//  Created by BruceYu on 15/12/14.
//  Copyright © 2015年 BruceYu. All rights reserved.
//

#import "SampleListViewController.h"
#import "ListViewController.h"
#import "DBObjectSampleViewController.h"
#import "RuntimeSampleViewController.h"
#import "DBObj.h"

@interface SampleListViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation SampleListViewController



- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.tableView config:^(UITableView *tableView) {
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.backgroundColor = [UIColor clearColor];
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }];
    [self.view addSubview:self.tableView];
    
    self.tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self setupCellData:self.startIndex];
    }];
    [self.tableView.header beginRefreshing];
}


- (void)setupCellData:(NSUInteger)pageNum
{
    //sample code
    NSArray *list = @[
                      @{@"AFN+JSON转Model.Sample":@"ListViewController"},
                      @{@"YUDBObject.Sample":@"DBObjectSampleViewController"},
                      @{@"UI.Sample":@"UIDebugSampleViewController"},
                      @{@"Runtime.Sample":@"RuntimeSampleViewController"},
                      
                      ];
    [self setupCellDataSuccessBlock:self.tableView](list);
}

-(void)updateViewConstraints{
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    [super updateViewConstraints];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark  delegate dataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.cellDataList count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44.f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellIdentifier"];
    cell.textLabel.text = [[self.cellDataList[indexPath.row] allKeys] firstObject];
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    return cell;
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView reloadDataAnimate:AnimationToLeft willDisplayCell:cell forRowAtIndexPath:indexPath duration:1 completion:nil];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    Class class = NSClassFromString([[self.cellDataList[indexPath.row] allValues] firstObject]);
    UIViewController* vc = [class controllerByDefaultStoryBoard];
    vc.title = [[self.cellDataList[indexPath.row] allKeys] firstObject];
    [vc setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:vc animated:YES];
}


#pragma mark - api

#pragma mark - model event
#pragma mark 1 notification
#pragma mark 2 KVO

#pragma mark - view event
#pragma mark 1 target-action
- (IBAction)refreshAction:(id)sender {
    [self.tableView.header beginRefreshing];
}

#pragma mark 2 delegate dataSource protocol

#pragma mark - private
#pragma mark - getter / setter

#pragma mark -
@end
