//
//  BaseViewController.m
//  YUKit<https://github.com/c6357/YUKit>
//
//  Created by BruceYu on 15/7/18.
//  Copyright (c) 2015年 BruceYu. All rights reserved.
//

#import "BaseViewController.h"
#import "YUKit.h"


@interface BaseViewController ()
//@property (nonatomic, strong) IQKeyboardReturnKeyHandler    *returnKeyHandler;
@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    
//    [self.view setBackgroundColor:BackgroundColor];
//    
//    IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
//    manager.enable = YES;
//    manager.shouldResignOnTouchOutside = YES;
//    manager.shouldToolbarUsesTextFieldTintColor = YES;
//    manager.enableAutoToolbar = YES;
////    manager.canAdjustTextView = YES;
////    manager.shouldFixTextViewClip = NO;
//    
//    self.returnKeyHandler = [[IQKeyboardReturnKeyHandler alloc] initWithViewController:self];
//    self.returnKeyHandler.lastTextFieldReturnKeyType = UIReturnKeyDone;
//    self.returnKeyHandler.toolbarManageBehaviour = IQAutoToolbarBySubviews;

//    [self.navigationController.navigationBar setBarStyle:UIBarStyleBlack];
    
#ifdef CustomNavigationBar
    UIButton *backBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 54, 44)];
//    backBtn.backgroundColor = [UIColor redColor];
    [backBtn setImage:[UIImage imageNamed:@"cmm_back"] forState:UIControlStateNormal];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    [backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
#endif
    
}

-(void)back{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)dealloc
{
//    self.returnKeyHandler = nil;
}

//- (BOOL)prefersStatusBarHidden
//{
//    // iOS7后,[[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationFade];
//    // 已经不起作用了
//    return YES;
//}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}


-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
//    [SVProgressHUD dismiss];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark -  setter getter
-(UIView *)backgroundView{
    if (!_backgroundView) {
        _backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, APP_WIDTH(), APP_HEIGHT()+20)];
        _backgroundView.backgroundColor = [UIColor blackColor];
        _backgroundView.alpha = 0.5;
    }
    return _backgroundView;
}

@end
