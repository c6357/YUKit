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
        [SettingCell registerForTable:tableView];
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
    SettingCell *cell = [SettingCell XIBCellFor:tableView];
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
                            [SettingInfo initWithTitle:@"CurrentLanguage" desrc:DeviceCurrentLanguage()],
                            [SettingInfo initWithTitle:@"Model" desrc:DeviceModel()],
                            
                            [SettingInfo initWithTitle:@"MacAddress" desrc:DeviceMacAddress()],
                            
                            [SettingInfo initWithTitle:@"LocalHost" desrc:DeviceLocalhost()],
                            [SettingInfo initWithTitle:@"IpAddressCell" desrc:DeviceIpAddressCell()],
                            [SettingInfo initWithTitle:@"MachineModel" desrc:DeviceMachineModel()],
                            [SettingInfo initWithTitle:@"MachineModelName" desrc:DeviceMachineModelName()],
                            [SettingInfo initWithTitle:@"SystemUptime" desrc:DeviceSystemUptime()],
                            ];
    [self.settingInfoMarry addObject:setInfoArry];
    
    
    setInfoArry = @[
                    [SettingInfo initWithTitle:@"AppCpuUsage" desrc:[self longFormatter:AppCpuUsage()]],
                    [SettingInfo initWithTitle:@"AppMemoryUsage" desrc:[self longFormatter:AppMemoryUsage()]],
                    ];
    [self.settingInfoMarry addObject:setInfoArry];
    
    
    
    setInfoArry = @[
                   [SettingInfo initWithTitle:@"DiskSpace" desrc:[self longFormatter:DeviceDiskSpace()]],
                   [SettingInfo initWithTitle:@"DiskSpaceFree" desrc:[self longFormatter:DeviceDiskSpaceFree()]],
                   [SettingInfo initWithTitle:@"DiskSpaceUsed" desrc:[self longFormatter:DeviceDiskSpaceUsed()]],
                   ];
    [self.settingInfoMarry addObject:setInfoArry];
    
    
    
    
    setInfoArry = @[
                    [SettingInfo initWithTitle:@"MemoryTotal" desrc:[self longFormatter:DeviceMemoryTotal()]],
                   [SettingInfo initWithTitle:@"MemoryUsed" desrc:[self longFormatter:DeviceMemoryUsed()]],
                   [SettingInfo initWithTitle:@"MemoryFree" desrc:[self longFormatter:DeviceMemoryFree()]],
                   [SettingInfo initWithTitle:@"MemoryActive" desrc:[self longFormatter:DeviceMemoryActive()]],
                   [SettingInfo initWithTitle:@"MemoryInactive" desrc:[self longFormatter:DeviceMemoryInactive()]],
                   [SettingInfo initWithTitle:@"MemoryWired" desrc:[self longFormatter:DeviceMemoryWired()]],
                   [SettingInfo initWithTitle:@"MemoryPurgable" desrc:[self longFormatter:DeviceMemoryPurgable()]],
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
