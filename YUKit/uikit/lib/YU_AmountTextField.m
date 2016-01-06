//
//  YU_AmountTextField.m
//  YUKit<https://github.com/c6357/YUKit>
//
//  Created by BruceYu on 15/9/7.
//  Copyright (c) 2015年 BruceYu. All rights reserved.
//

#import "YU_AmountTextField.h"
#import "NSString+YUCheck.h"

@implementation YUAmountTextField

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    //小数点两位
    NSMutableString * futureString = [NSMutableString stringWithString:textField.text];
    [futureString replaceCharactersInRange:range withString:string];
    
    int flag = 0;
    const NSInteger limited = 2;
    for (NSInteger i = futureString.length - 1; i>=0; i--) {
        
        if ([futureString characterAtIndex:i] == '.') {
            
            if (flag > limited) {
                return NO;
            }
            break;
        }
        flag++;
    }
    
    NSInteger ff       = (flag>2 ? 0:(flag?(flag+1):0));
    NSString * aString = [textField.text stringByReplacingCharactersInRange:range withString:string];

    if ([aString length] >= YU_AMOUNTTEXTFIELD_MAX_LENTH + ff) {
        textField.text    = [aString substringToIndex:YU_AMOUNTTEXTFIELD_MAX_LENTH + ff];
        return NO;
    }
    
    if ([futureString isDecimal] || [string length] == 0 || ([string isEqualToString:@"."] && [textField.text rangeOfString:@"."].location == NSNotFound)) {
        return YES;
    }
    return NO;
}

@end
