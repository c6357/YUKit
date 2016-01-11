//
//       \\     //    ========     \\    //
//        \\   //          ==       \\  //
//         \\ //         ==          \\//
//          ||          ==           //\\
//          ||        ==            //  \\
//          ||       ========      //    \\
//
//  SystemInformationViewController.m
//  YUKit
//
//  Created by BruceYu on 15/12/15.
//  Copyright © 2015年 BruceYu. All rights reserved.
//

#import "SystemInformationViewController.h"


#define MB (1024*1024)
#define GB (MB*1024)


@interface SystemInformationViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)NSMutableArray *settingInfoMarry;
@end

@implementation SystemInformationViewController


#pragma mark - def

#pragma mark - override

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.tableView config:^(UITableView *tableView) {
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }];
    [self.view addSubview:self.tableView];
    
    [self configSetInfo];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)updateViewConstraints{
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    [super updateViewConstraints];
}
- (IBAction)done:(id)sender {
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark  delegate dataSource
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [self.settingInfoMarry count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [[self.settingInfoMarry objectAtIndex:section] count];
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *backVIew = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 20)];
    backVIew.backgroundColor = [UIColor groupTableViewBackgroundColor];
    return backVIew;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return  section ? 20 :0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SettingCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellIdentifier"];
    if(cell == nil){
        [tableView registerNib:[UINib nibWithNibName:@"SettingCell" bundle:Nil] forCellReuseIdentifier:@"cellIdentifier"];
        cell = [tableView dequeueReusableCellWithIdentifier:@"cellIdentifier"];
    }
    
    
    SettingInfo *setInfo = [[self.settingInfoMarry objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    [cell setSetInfo:setInfo];
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    SettingInfo *setInfo = [[self.settingInfoMarry objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    if(setInfo.didSelectRowBlock){
        setInfo.didSelectRowBlock();
    }
}

#pragma mark - private
#pragma mark - getter / setter
-(NSMutableArray *)settingInfoMarry
{
    if (!_settingInfoMarry) {
        _settingInfoMarry = [NSMutableArray array];
    }
    return _settingInfoMarry;
}

#pragma mark -
-(void)configSetInfo{
    NSArray *setInfoArry = @[
                            [SettingInfo initWithTitle:@"CurrentLanguage" desrc:Device_CurrentLanguage()],
                            [SettingInfo initWithTitle:@"Model" desrc:Device_Model()],
                            
                            [SettingInfo initWithTitle:@"MacAddress" desrc:Device_MacAddress()],
                            
                            [SettingInfo initWithTitle:@"LocalHost" desrc:Device_LocalHost()],
                            [SettingInfo initWithTitle:@"IpAddressCell" desrc:Device_IpAddressCell()],
                            [SettingInfo initWithTitle:@"MachineModel" desrc:Device_MachineModel()],
                            [SettingInfo initWithTitle:@"MachineModelName" desrc:Device_MachineModelName()],
                            [SettingInfo initWithTitle:@"SystemUptime" desrc:Device_SystemUptime()],
                            ];
    [self.settingInfoMarry addObject:setInfoArry];
    
    
    setInfoArry = @[
                    [SettingInfo initWithTitle:@"APP_CpuUsage" desrc:[self longFormatter:APP_CpuUsage()]],
                    [SettingInfo initWithTitle:@"APP_MemoryUsage" desrc:[self longFormatter:APP_MemoryUsage()]],
                    ];
    [self.settingInfoMarry addObject:setInfoArry];
    
    
    
    setInfoArry = @[
                   [SettingInfo initWithTitle:@"DiskSpace" desrc:[self longFormatter:Device_DiskSpace()]],
                   [SettingInfo initWithTitle:@"DiskSpaceFree" desrc:[self longFormatter:Device_DiskSpaceFree()]],
                   [SettingInfo initWithTitle:@"DiskSpaceUsed" desrc:[self longFormatter:Device_DiskSpaceUsed()]],
                   ];
    [self.settingInfoMarry addObject:setInfoArry];
    
    
    
    
    setInfoArry = @[
                    [SettingInfo initWithTitle:@"MemoryTotal" desrc:[self longFormatter:Device_MemoryTotal()]],
                   [SettingInfo initWithTitle:@"MemoryUsed" desrc:[self longFormatter:Device_MemoryUsed()]],
                   [SettingInfo initWithTitle:@"MemoryFree" desrc:[self longFormatter:Device_MemoryFree()]],
                   [SettingInfo initWithTitle:@"MemoryActive" desrc:[self longFormatter:Device_MemoryActive()]],
                   [SettingInfo initWithTitle:@"MemoryInactive" desrc:[self longFormatter:Device_MemoryInactive()]],
                   [SettingInfo initWithTitle:@"MemoryWired" desrc:[self longFormatter:Device_MemoryWired()]],
                   [SettingInfo initWithTitle:@"MemoryPurgable" desrc:[self longFormatter:Device_MemoryPurgable()]],
                   ];
    [self.settingInfoMarry addObject:setInfoArry];
}

#pragma mark - private

#if TARGET_OS_EMBEDDED
//iPhone Device
#endif

#if TARGET_IPHONE_SIMULATOR
//iPhone Simulator
#endif

- (NSString *)longFormatter:(long long)diskSpace {
    
    NSString *formatted;
    double bytes = 1.0 * diskSpace;
    double megabytes = bytes / MB;
    double gigabytes = bytes / GB;
    if (gigabytes >= 1.0)
        formatted = [NSString stringWithFormat:@"%.2f GB", gigabytes];
    else if (megabytes >= 1.0)
        formatted = [NSString stringWithFormat:@"%.2f MB", megabytes];
    else
        formatted = [NSString stringWithFormat:@"%.2f bytes", bytes];

    return formatted;
}
@end
