//
//  UIWindow+YU.h
//  YUKit<https://github.com/c6357/YUKit>
//
//  Created by BruceYu on 15/12/28.
//  Copyright © 2015年 BruceYu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIWindow (YU)

@end


@class DebugView;
@interface UIView (Debug)

-(void)showViewFrames;

-(void)showViewFrameSize;

@end


@interface DebugView : UIView

@end
