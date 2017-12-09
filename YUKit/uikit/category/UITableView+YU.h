//
//  UITableView+YU.h
//  YUKit<https://github.com/c6357/YUKit>
//
//  Created by BruceYu on 15/9/2.
//  Copyright (c) 2015年 BruceYu. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,YUAnimation) {
    AnimationToLeft,
    AnimationToRight
};

@interface UITableView (YU)

-(void)yu_ScrollViewDidScroll:(UIScrollView *)scrollView Animation:(BOOL)animation;

- (CAAnimationGroup*)yu_reloadDataAnimate:(YUAnimation)animation willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath duration:(CFTimeInterval)duration completion:(void(^)(void))completion;

-(void)yu_ReloadData;
-(void)yu_ReloadData:(NSString*)message;

-(void)yu_showEmptyView:(NSString*)message;
-(void)yu_hideEmptyView;


-(void)yu_registerNibWithCell:(UITableViewCell*)cell;
-(void)yu_registerClassWithCell:(UITableViewCell*)cell;
@end
