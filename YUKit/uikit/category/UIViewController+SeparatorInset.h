//
//  UIViewController+SeparatorInset.h
//  YUKit<https://github.com/c6357/YUKit>
//
//  Created by BruceYu on 15/9/2.
//  Copyright (c) 2015年 BruceYu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (SeparatorInset)

- (void)yu_setSeparatorInsetZeroWithTableView:(UITableView *)tableView;

- (void)yu_setSeparatorInsetWithTableView:(UITableView *)tableView inset:(UIEdgeInsets)inset;

/*
 If you want to implement 'tableView:willDisplayCell:forRowAtIndexPath:' for
 tableview delegate,you should use this method.
 */
- (void)yu_tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath;

@end
