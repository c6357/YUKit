//
//  YU_TextView.h
//  YUKit<https://github.com/c6357/YUKit>
//
//  Created by BruceYu on 15/9/7.
//  Copyright (c) 2015年 BruceYu. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 * textView 文本输入框
 */

@interface YUTextView : UITextView

/**
 *default is nil. string is drawn 70% gray
 */
@property(nonatomic, retain) NSString *placeholder;


/**
 * 自动适应高度
 **/
-(void)setToFit;


@end
