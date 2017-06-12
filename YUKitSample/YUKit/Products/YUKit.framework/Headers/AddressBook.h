//
//  AddressBook.h
//  YUAddressBook<https://github.com/c6357/YUAddressBook>
//
//  Created by BruceYu on 15/8/1.
//  Copyright (c) 2015年 BruceYu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AddressBookObj.h"
#import "YU_Singleton.h"

@interface AddressBook : NSObject



YUSingletonH(AddressBook)

/**
 * 返回通讯录对象
 *
 * @return (AddressBookObj)
 **/

+(NSMutableArray*)addressBooks;


/**
 * 判断是否存在 phoneNum
 *
 * @param phoneNum 联系人电话
 *
 * @return (NSMutableArray)
 **/

+(BOOL)containPhoneNum:(NSString*)phoneNum;


@end
