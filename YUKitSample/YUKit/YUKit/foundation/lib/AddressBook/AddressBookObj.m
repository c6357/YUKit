//
//  AddressBookObj.m
//  YUAddressBook<https://github.com/c6357/YUAddressBook>
//
//  Created by BruceYu on 15/8/1.
//  Copyright (c) 2015年 BruceYu. All rights reserved.
//

#import "AddressBookObj.h"

@implementation AddressBookObj
-(NSMutableDictionary *)phoneInfo
{
    if(_phoneInfo == nil)
    {
        _phoneInfo = [[NSMutableDictionary alloc] init];
    }
    return _phoneInfo;
}
@end
