//
//  NavigationController.h
//  YUKit<https://github.com/c6357/YUKit>
//
//  Created by BruceYu on 15/7/21.
//  Copyright (c) 2015年 BruceYu. All rights reserved.
//

#import "NavigationController.h"

@interface NavigationController ()<UINavigationBarDelegate>

@end

@implementation NavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationBar.barTintColor = [UIColor whiteColor];
    self.navigationBar.translucent = YES;
    
    
//    NSDictionary * dict=[NSDictionary dictionaryWithObject:[UIColor whiteColor] forKey:UITextAttributeTextColor];
//    self.navigationBar.titleTextAttributes = dict;
    
//    [self.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSBackgroundColorAttributeName,[UIFont fontWithName:@"Marion-Italic" size:20.0],NSFontAttributeName,nil]];
    
    
#ifdef CustomNavigationBar
    [self.navigationBar setTitleTextAttributes:
     
  @{NSFontAttributeName:[UIFont boldSystemFontOfSize:24],
    
    NSForegroundColorAttributeName:[UIColor whiteColor]}];

    [self.navigationBar setBackgroundImage:[UIImage imageNamed:@"cmm_bg.png"] forBarMetrics:UIBarMetricsCompact];
    
#endif
//    self.navigationBar.translucent = NO;
//    self.edgesForExtendedLayout = UIRectEdgeNone;
//    [self setNeedsStatusBarAppearanceUpdate];
//    self.edgesForExtendedLayout = UIRectEdgeNone;
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

@end
