//
//       \\     //    ========     \\    //
//        \\   //          ==       \\  //
//         \\ //         ==          \\//
//          ||          ==           //\\
//          ||        ==            //  \\
//          ||       ========      //    \\
//
//  ListViewController.m
//  YUKit<https://github.com/c6357/YUKit>
//
//  Created by BruceYu on 15/12/14.
//  Copyright © 2015年 BruceYu. All rights reserved.
//

#import "LIstViewController.h"
#import "YUService+Sample.h"
#import "ListCell.h"

@interface ListViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation ListViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.tableView config:^(UITableView *tableView) {
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.backgroundColor = [UIColor clearColor];
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [ListCell registerForTable:tableView];
    }];
    [self.view addSubview:self.tableView];
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self setupCellData:self.startIndex];
    }];
    
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [self setupCellData:self.currentPageIndex+1];
    }];

    [self.tableView.mj_header beginRefreshing];
}

- (void)setupCellData:(NSUInteger)pageNum
{
    @weakify(self);
    [YUService GetSampleList:^(NSArray *List) {
        @strongify(self);
        if (pageNum == self.startIndex) {
            [self setupCellDataSuccessBlock:self.tableView](List);
            [self.tableView yuReloadData];
        } else {
            [self addNewCellDataSuccessBlock:self.tableView](List);
        }
        
    } failure:[self setupCellDataFailureBlock:self.tableView]];
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
    ListCell *cell = [ListCell XIBCellFor:tableView];
    [cell setModel:self.cellDataList[indexPath.row]];
    
    return cell;
}

/*-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView reloadDataAnimate:AnimationToLeft willDisplayCell:cell forRowAtIndexPath:indexPath duration:0.5 completion:nil];
}*/

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    ListModel *obj = self.cellDataList[indexPath.row];
    [UIAlertView showInfo:ComboString(@"%@", [obj dictionary]) time:3];
}

#pragma mark - private
#pragma mark - getter / setter

#pragma mark -
@end
