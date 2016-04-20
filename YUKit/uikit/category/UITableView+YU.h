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

-(void)yuScrollViewDidScroll:(UIScrollView *)scrollView Animation:(BOOL)animation;

- (CAAnimationGroup*)reloadDataAnimate:(YUAnimation)animation willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath duration:(CFTimeInterval)duration completion:(void(^)())completion;

-(void)yuReloadData;
-(void)yuReloadData:(NSString*)message;

-(void)showEmptyView:(NSString*)message;
-(void)hideEmptyView;

@end
