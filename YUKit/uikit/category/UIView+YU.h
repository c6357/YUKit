//
//  UIView+YU.h
//  YUKit<https://github.com/c6357/YUKit>
//
//  Created by BruceYu on 15/9/2.
//  Copyright (c) 2015年 BruceYu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (YU)
-(CGFloat)W;
-(CGFloat)H;
-(CGFloat)TX;
-(CGFloat)TY;
-(CGFloat)BX;
-(CGFloat)BY;

/**
 Method that adds a gradient sublayer inthat view
 */
- (CAGradientLayer *)addLinearGradientWithColor:(UIColor *)theColor transparentToOpaque:(BOOL)transparentToOpaque;
/**
 Methot that capture a image from that view
 */
- (UIImageView *) imageInNavController: (UINavigationController *) navController;
/**
 Method that adds a view with color in that view
 */
- (UIView *)addOpacityWithColor:(UIColor *)theColor;


+(id)XIBView;


-(id)replacementForXibView;


#pragma mark - ws
typedef enum{
    Direct_Up,
    Direct_Down,
    Direct_Left,
    Direct_Right
}Direction;

//by W.S
-(CAGradientLayer*)gradientLayer;
-(void)setBackgroundWithGradientColor:(NSArray*)colors;
-(void)setFrame:(CGRect)frame animation:(BOOL)animated completion:(void(^)(BOOL))completion;
-(void)move:(float)offset direct:(Direction)direction animation:(BOOL)animated;
-(void)moveUp:(NSNumber*)offset animation:(BOOL)animated;
-(void)moveDown:(NSNumber*)offset animation:(BOOL)animated;
-(void)moveDown:(NSNumber*)offset;
-(void)moevrTo:(CGPoint)nPoint animation:(BOOL)animated;
-(void)moveToShowHide:(float)offset direct:(Direction)direction animation:(BOOL)animated;
-(void)moveToHCenter:(BOOL)animated;
-(void)strechTo:(CGSize)nSize animation:(BOOL)animated;
-(void)strech:(float)offset direct:(Direction)direction animation:(BOOL)animated;
-(void)setHidden:(BOOL)hidden animation:(BOOL)animation;
-(void)setHeight:(float)height;
-(void)setHeight:(float)height animation:(BOOL)animtated;

-(void)setWidth:(float)width;
-(void)setOrigin:(CGPoint)orgin;
-(float)reAliginFollow:(UILabel*)label direct:(Direction)direction;

-(void)setToSuperCenter;


-(NSIndexPath*)IndexPath;
-(void)setIndexPath:(NSIndexPath*)indexPath;


-(id)Obj;
-(void)setObj:(NSIndexPath *)obj;


-(BOOL)autoSizeToFitContent;
-(void)setAutoSizeToFitContent:(BOOL)autoFit;

-(void)addClickGesture:(void (^)(void))handler;
-(void)removeClickGesture;

enum {
    BorderTop = 0x01,
    BorderLeft = 0x02,
    BorderBottom = 0x04,
    BorderRight = 0x08
};
//@property (nonatomic,assign) NSInteger viewBorderStyle;
//@property (nonatomic,assign) NSInteger viewBorderLineWidth;
-(void)setViewBorderStyle:(NSInteger)viewBorderStyle;
-(void)setViewBorderLineWidth:(NSInteger)viewBorderLineWidth;

/**
 *	@brief	浏览头像
 *	@param 	imageView 	头像所在的View
 */
+(void)showImage:(UIButton*)headBtn;
@end
