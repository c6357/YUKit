//
//  UIView+YUFrame.m
//  YUKit<https://github.com/c6357/YUKit>
//
//  Created by BruceYu on 15/9/2.
//  Copyright (c) 2015年 BruceYu. All rights reserved.
//

#import "UIView+YUFrame.h"

@implementation UIView (YUFrame)

CGFloat VIEW_W(UIView* view){
    return FRAME_W(view.frame);
}
CGFloat VIEW_H(UIView* view){
    return FRAME_H(view.frame);
}
CGFloat VIEW_TX(UIView* view){
    return FRAME_TX(view.frame);
}
CGFloat VIEW_TY(UIView* view){
    return FRAME_TY(view.frame);
}
CGFloat VIEW_BX(UIView* view){
    return FRAME_BX(view.frame);
}
CGFloat VIEW_BY(UIView* view){
    return FRAME_BY(view.frame);
}
CGFloat FRAME_W(CGRect frame){
    return frame.size.width;
}
CGFloat FRAME_H(CGRect frame){
    return frame.size.height;
}
CGFloat FRAME_TX(CGRect frame){
    return frame.origin.x;
}
CGFloat FRAME_TY(CGRect frame){
    return frame.origin.y;
}
CGFloat FRAME_BX(CGRect frame){
    return frame.origin.x + frame.size.width;
}
CGFloat FRAME_BY(CGRect frame){
    return frame.origin.y + frame.size.height;
}
-(CGFloat)W{
    return VIEW_W(self);
}
-(CGFloat)H{
    return VIEW_H(self);
}
-(CGFloat)TX{
    return VIEW_TX(self);
}
-(CGFloat)TY{
    return VIEW_TY(self);
}
-(CGFloat)BX{
    return VIEW_BX(self);
}
-(CGFloat)BY{
    return VIEW_BY(self);
}
@end
