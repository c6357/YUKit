//
//  UITableView+BaseClass.h
//  YUKit<https://github.com/c6357/YUKit>
//
//  Created by BruceYu on 15/4/15.
//  Copyright (c) 2015年 BruceYu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableView (BaseClass)

- (void)config:(void (^)(UITableView *tableView))configTableViewBlock;

@end
