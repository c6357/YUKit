//
//  UITableViewCell+YU.m
//  YUKit<https://github.com/c6357/YUKit>
//
//  Created by BruceYu on 15/9/7.
//  Copyright (c) 2015年 BruceYu. All rights reserved.
//

#import "UITableViewCell+YU.h"

@implementation UITableViewCell (YU)
+(id)XIBView
{
    id obj = [[[NSBundle mainBundle] loadNibNamed:[NSString stringWithUTF8String:object_getClassName(self)] owner:nil options:nil] objectAtIndex:0];
    return obj;
}

+(void)load{
//    self.layer.borderColor = [UIColor blueColor].CGColor;
//    self.layer.borderWidth = 1.0;
}

+(id)XIBCellFor:(UITableView*)tableView
{
    NSString *cellIdentifier = NSStringFromClass([self class]);
    return [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
}

+(void)registerForTable:(UITableView*)tableView
{
    NSString *cellIdentifier = NSStringFromClass([self class]);
    UINib *nib = [UINib nibWithNibName:cellIdentifier bundle:nil];
    [tableView registerNib:nib forCellReuseIdentifier:cellIdentifier];
}


@end
