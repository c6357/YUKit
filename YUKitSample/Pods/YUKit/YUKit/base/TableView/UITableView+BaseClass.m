//
//  UITableView+BaseClass.m
//  YUKit<https://github.com/c6357/YUKit>
//
//  Created by BruceYu on 15/4/15.
//  Copyright (c) 2015年 BruceYu. All rights reserved.
//

#import "UITableView+BaseClass.h"

@implementation UITableView (BaseClass)

- (void)config:(void (^)(UITableView *tableView))configTableViewBlock
{
    if (configTableViewBlock) {
        configTableViewBlock(self);
    }
}

@end
