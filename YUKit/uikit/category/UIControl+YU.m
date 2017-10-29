//
//  UIControl+YU.m
//  YUKit<https://github.com/c6357/YUKit>
//
//  Created by BruceYu on 15/12/28.
//  Copyright © 2015年 BruceYu. All rights reserved.
//

#import "UIControl+YU.h"
#import "YUKit.h"

@implementation UIControl (YU)
static CGRect oldframe;
+(void)yu_showImage:(UIButton*)headBtn{
    
    UIImage *image = headBtn.currentBackgroundImage;
    if (!image) {
        image = headBtn.currentImage;
    }
    
    if (!image) {
        return;
    }
    
    //    NSAssert(image != nil, @"image must be non-nil");
    
    UIWindow *window=[UIApplication sharedApplication].keyWindow;
    
    UIView *backgroundView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    backgroundView.backgroundColor=[UIColor blackColor];
    backgroundView.alpha=0;
    
    
    oldframe=[headBtn convertRect:headBtn.bounds toView:window];
    
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:oldframe];
    imageView.tag=1;
    imageView.image = image;
    [backgroundView addSubview:imageView];
    [window addSubview:backgroundView];
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideImage:)];
    [backgroundView addGestureRecognizer: tap];
    
    
    
    YU_VoidBlock ShowImg = ^{
        imageView.frame=CGRectMake(imageView.frame.origin.x,imageView.frame.origin.y, 0, 0);
        [UIView animateWithDuration:0.35 animations:^{
            imageView.frame=CGRectMake(0,([UIScreen mainScreen].bounds.size.height-image.size.height*[UIScreen mainScreen].bounds.size.width/image.size.width)/2, [UIScreen mainScreen].bounds.size.width, image.size.height*[UIScreen mainScreen].bounds.size.width/image.size.width);
            backgroundView.alpha = 1;
            imageView.alpha = 1;
        } completion:^(BOOL finished) {
            
        }];
    };
    
    
    ShowImg();
    
    
#define SP_width 60.f
    //    UIActivityIndicatorView* _spinnerView  = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    //    _spinnerView.frame = CGRectMake((VIEW_W(backgroundView) - SP_width)/2, (VIEW_H(backgroundView) - SP_width)/2, SP_width, SP_width);
    //    [backgroundView addSubview:_spinnerView];
    //    [_spinnerView startAnimating];
    //
    //    [_spinnerView setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleGray];
    
    
    //    NSString *headUrl = [NSString stringWithFormat:DownloadHeadUrl,[SDataCenter userLogonInfo].accessToken,headBtn.OBJ];
    //    [imageView sd_setImageWithURL:[NSURL URLWithString:headUrl] placeholderImage:headBtn.currentBackgroundImage completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
    //        image = headBtn.currentBackgroundImage;
    //        [_spinnerView stopAnimating];
    //        imageView.alpha = 1 ;
    //    }];
}


+(void)hideImage:(UITapGestureRecognizer*)tap{
    UIView *backgroundView=tap.view;
    UIButton *imageView=(UIButton*)[tap.view viewWithTag:1];
    [UIView animateWithDuration:0.3 animations:^{
        imageView.frame=oldframe;
        backgroundView.alpha=0;
    } completion:^(BOOL finished) {
        [backgroundView removeFromSuperview];
    }];
}

//+ (void) transitionWithType:(NSString *) type WithSubtype:(NSString *) subtype ForView : (UIView *) view
//{
//    //创建CATransition对象
//    CATransition *animation = [CATransition animation];
//
//    //设置运动时间
//    animation.duration = .3;
//
//    //设置运动type
//    animation.type = type;
//    if (subtype != nil) {
//        //设置子类
//        animation.subtype = subtype;
//    }
//
//    //设置运动速度
//    animation.timingFunction = UIViewAnimationOptionCurveEaseInOut;
//
//    [view.layer addAnimation:animation forKey:@"animation"];
//}
@end
