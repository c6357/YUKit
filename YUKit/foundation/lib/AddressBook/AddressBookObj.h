//
//  AddressBookObj.h
//  YUAddressBook<https://github.com/c6357/YUAddressBook>
//
//  Created by BruceYu on 15/8/1.
//  Copyright (c) 2015年 BruceYu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AddressBookObj : NSObject
@property (nonatomic,assign) int recordID;
@property (nonatomic,strong) NSString *compositeName;
@property (nonatomic,strong) NSString *pbone;
@property (nonatomic,strong) NSMutableDictionary *phoneInfo;
@end
