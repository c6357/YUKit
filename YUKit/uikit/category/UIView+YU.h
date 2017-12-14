//
//  UIView+YU.h
//  YUKit<https://github.com/c6357/YUKit>
//
//  Created by BruceYu on 15/9/2.
//  Copyright (c) 2015年 BruceYu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (YU)


+(UIView *)yu_viewWithTitle:(NSString*)title;


- (UIImage *)yu_imageFromView;



/**
 Method that adds a gradient sublayer inthat view
 */
- (CAGradientLayer *)yu_addLinearGradientWithColor:(UIColor *)theColor transparentToOpaque:(BOOL)transparentToOpaque;
/**
 Methot that capture a image from that view
 */
- (UIImageView *) yu_imageInNavController: (UINavigationController *) navController;
/**
 Method that adds a view with color in that view
 */
- (UIView *)yu_addOpacityWithColor:(UIColor *)theColor;


+(id)yu_xibView;


-(id)yu_replacementForXibView;


#pragma mark - ws
typedef enum{
    Direct_Up,
    Direct_Down,
    Direct_Left,
    Direct_Right
}Direction;

//by W.S
-(CAGradientLayer*)yu_gradientLayer;
-(void)yu_setBackgroundWithGradientColor:(NSArray*)colors;
-(void)yu_setFrame:(CGRect)frame animation:(BOOL)animated completion:(void(^)(BOOL))completion;
-(void)yu_move:(float)offset direct:(Direction)direction animation:(BOOL)animated;
-(void)yu_moveUp:(NSNumber*)offset animation:(BOOL)animated;
-(void)yu_moveDown:(NSNumber*)offset animation:(BOOL)animated;
-(void)yu_moveDown:(NSNumber*)offset;
-(void)yu_moevrTo:(CGPoint)nPoint animation:(BOOL)animated;
-(void)yu_moveToShowHide:(float)offset direct:(Direction)direction animation:(BOOL)animated;
-(void)yu_moveToHCenter:(BOOL)animated;
-(void)yu_strechTo:(CGSize)nSize animation:(BOOL)animated;
-(void)yu_strech:(float)offset direct:(Direction)direction animation:(BOOL)animated;
-(void)yu_setHidden:(BOOL)hidden animation:(BOOL)animation;
-(void)yu_setHeight:(float)height;
-(void)yu_setHeight:(float)height animation:(BOOL)animtated;

-(void)yu_setWidth:(float)width;
-(void)yu_setOrigin:(CGPoint)orgin;
-(float)yu_reAliginFollow:(UILabel*)label direct:(Direction)direction;

-(void)yu_setToSuperCenter;


-(BOOL)yu_autoSizeToFitContent;
-(void)yu_setAutoSizeToFitContent:(BOOL)autoFit;

-(void)yu_addClickGesture:(void (^)(void))handler;
-(void)yu_removeClickGesture;

enum {
    BorderTop = 0x01,
    BorderLeft = 0x02,
    BorderBottom = 0x04,
    BorderRight = 0x08
};


//@property (nonatomic,assign) NSInteger viewBorderStyle;
//@property (nonatomic,assign) NSInteger viewBorderLineWidth;
-(void)yu_setViewBorderStyle:(NSInteger)viewBorderStyle;
-(void)yu_setViewBorderLineWidth:(NSInteger)viewBorderLineWidth;


@end
