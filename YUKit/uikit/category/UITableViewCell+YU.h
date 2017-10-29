//
//  UITableViewCell+YU.h
//  YUKit<https://github.com/c6357/YUKit>
//
//  Created by BruceYu on 15/9/7.
//  Copyright (c) 2015年 BruceYu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableViewCell (YU)

+(id)yu_xibView;

+(id)yu_xibCellFor:(UITableView*)tableView;

+(void)yu_registerForTable:(UITableView*)tableView;

@end
