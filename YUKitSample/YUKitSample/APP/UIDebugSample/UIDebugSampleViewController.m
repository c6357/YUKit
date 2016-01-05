//
//       \\     //    ========     \\    //
//        \\   //          ==       \\  //
//         \\ //         ==          \\//
//          ||          ==           //\\
//          ||        ==            //  \\
//          ||       ========      //    \\
//
//  UIDebugSampleViewController.m
//  YUKit
//
//  Created by BruceYu on 15/12/28.
//  Copyright © 2015年 BruceYu. All rights reserved.
//

#import "UIDebugSampleViewController.h"

@interface UIDebugSampleViewController ()
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@end

@implementation UIDebugSampleViewController


#pragma mark - def

#pragma mark - override

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    for (UIView *view in self.scrollView.subviews) {
        
        [view showViewFrames];
        [view showViewFrameSize];
        
        UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(onViewPanned:)];
        [view addGestureRecognizer:panGestureRecognizer];
    }
}


-(void)onViewPanned:(UIPanGestureRecognizer*)gesture{

    CGPoint translation = [gesture translationInView:self.view];
    gesture.view.frame = CGRectOffset(gesture.view.frame, translation.x, translation.y);
    [gesture setTranslation:CGPointMake(0, 0) inView:self.view];
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - api

#pragma mark - model event
#pragma mark 1 notification
#pragma mark 2 KVO

#pragma mark - view event
#pragma mark 1 target-action
#pragma mark 2 delegate dataSource protocol

#pragma mark - private
#pragma mark - getter / setter

#pragma mark -
@end
