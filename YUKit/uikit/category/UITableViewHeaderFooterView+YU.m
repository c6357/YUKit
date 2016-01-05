//
//  UITableViewHeaderFooterView+YU.m
//  YUKit<https://github.com/c6357/YUKit>
//
//  Created by BruceYu on 15/9/7.
//  Copyright (c) 2015年 BruceYu. All rights reserved.
//

#import "UITableViewHeaderFooterView+YU.h"

@implementation UITableViewHeaderFooterView (YU)

+(void)registerForTableHeaderFooter:(UITableView*)table
{
    NSString *cellIdentifier = NSStringFromClass([self class]);
    UINib *nib = [UINib nibWithNibName:cellIdentifier bundle:nil];
    [table registerNib:nib forHeaderFooterViewReuseIdentifier:cellIdentifier];
}

+(id)XIBViewForTableHeaderFooter:(UITableView*)table
{
    
    NSString *cellIdentifier = NSStringFromClass([self class]);
    return [table dequeueReusableHeaderFooterViewWithIdentifier:cellIdentifier];
}

@end
