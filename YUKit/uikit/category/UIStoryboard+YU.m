//
//  UIStoryboard+YU.m
//  YUKit<https://github.com/c6357/YUKit>
//
//  Created by BruceYu on 15/12/16.
//  Copyright © 2015年 BruceYu. All rights reserved.
//

#import "UIStoryboard+YU.h"

@implementation UIStoryboard (YU)

+(UIViewController*)storyboardWithName:(NSString*)identifier{
    
  return  [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:identifier];
    
}

@end
