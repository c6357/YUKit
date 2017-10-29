//
//  UIView+YUFrame.h
//  YUKit<https://github.com/c6357/YUKit>
//
//  Created by BruceYu on 15/9/2.
//  Copyright (c) 2015年 BruceYu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (YUFrame)
/*
 (p1)----------(p2)
    |          |
    |          |
    |          |
    |          |
 (p3)----------(p4)
 
 p1 = (TX,TY) p2 = (BX,TY) p3 = (TX,BY) p4 = (BX,BY)
 */
UIKIT_EXTERN CGFloat YU_VIEW_W(UIView*);
UIKIT_EXTERN CGFloat YU_VIEW_H(UIView*);
UIKIT_EXTERN CGFloat YU_VIEW_TX(UIView*);
UIKIT_EXTERN CGFloat YU_VIEW_TY(UIView*);
UIKIT_EXTERN CGFloat YU_VIEW_BX(UIView*);
UIKIT_EXTERN CGFloat YU_VIEW_BY(UIView*);

UIKIT_EXTERN CGFloat YU_FRAME_W(CGRect);
UIKIT_EXTERN CGFloat YU_FRAME_H(CGRect);
UIKIT_EXTERN CGFloat YU_FRAME_TX(CGRect);
UIKIT_EXTERN CGFloat YU_FRAME_TY(CGRect);
UIKIT_EXTERN CGFloat YU_FRAME_BX(CGRect);
UIKIT_EXTERN CGFloat YU_FRAME_BY(CGRect);

//得到视图的尺寸:宽度、高度
-(CGFloat)YU_W;
-(CGFloat)YU_H;

//得到视图的left top的X,Y坐标点
-(CGFloat)YU_TX;
-(CGFloat)YU_TY;

//得到视图的right bottom的X,Y坐标点
-(CGFloat)YU_BX;
-(CGFloat)YU_BY;


@property (nonatomic,assign) CGSize size;
@property (nonatomic,assign) CGFloat x;
@property (nonatomic,assign) CGFloat y;
@property (nonatomic,assign) CGFloat width;
@property (nonatomic,assign) CGFloat height;
@property (nonatomic,assign) CGFloat centerX;
@property (nonatomic,assign) CGFloat centerY;
@end
