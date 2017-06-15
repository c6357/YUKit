//
//  AddressBook.m
//  YUAddressBook<https://github.com/c6357/YUAddressBook>
//
//  Created by BruceYu on 15/8/1.
//  Copyright (c) 2015年 BruceYu. All rights reserved.
//

#import <AddressBook/AddressBook.h>
#import <UIKit/UIKit.h>
#import "AddressBook.h"
#import "YUKit.h"

@interface AddressBook(){
    NSString *_privateName;
}
@property (assign,nonatomic)ABAddressBookRef addressBooksRef;
@property (strong,nonatomic)NSMutableArray *addressBooksArr;
@end

@implementation AddressBook
YUSingletonM(AddressBook)

- (id)init
{
    self = [super init];
    if (self) {
        _privateName = @"name";
    }
    return self;
}

//- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector
//{
//    NSMethodSignature* signature = [super methodSignatureForSelector:aSelector];
//    if (signature==nil) {
//        signature = [_addressBooksArr methodSignatureForSelector:aSelector];
//    }
//    NSUInteger argCount = [signature numberOfArguments];
//    for (NSInteger i=0 ; i<argCount ; i++) {
//        NSLog(@"%s" , [signature getArgumentTypeAtIndex:i]);
//    }
//    NSLog(@"returnType:%s ,returnLen:%lu" , [signature methodReturnType] , (unsigned long)[signature methodReturnLength]);
//    NSLog(@"signature:%@" , signature);
//    return signature;
//}
//
//- (void)forwardInvocation:(NSInvocation *)anInvocation
//{
//    NSLog(@"forwardInvocation:%@" , anInvocation);
//    SEL seletor = [anInvocation selector];
//    
//    if ([_addressBooksArr respondsToSelector:seletor]) {
//        [anInvocation invokeWithTarget:_addressBooksArr];
//    }
//    
//}


#pragma mark -
-(ABAddressBookRef)addressBooksRef{
    
    if (!_addressBooksRef) {
        
        if ([[UIDevice currentDevice].systemVersion floatValue] >= 6.0)
        {
            _addressBooksRef =  ABAddressBookCreateWithOptions(NULL, NULL);
            
            dispatch_semaphore_t sema = dispatch_semaphore_create(0);
            ABAddressBookRequestAccessWithCompletion(_addressBooksRef, ^(bool granted, CFErrorRef error){dispatch_semaphore_signal(sema);});
            dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
            
        }else{
            
            _addressBooksRef = ABAddressBookCreateWithOptions(_addressBooksRef, nil);
        }
    }
    return _addressBooksRef;
}


-(NSMutableArray *)addressBooksArr{
    
    if (!_addressBooksArr) {
        
        _addressBooksArr = [NSMutableArray array];
        
        NSArray *contacts = (__bridge NSArray *)ABAddressBookCopyArrayOfAllPeople(self.addressBooksRef);
        
        NSInteger contactsCount = [contacts count];
        
        for(int i = 0; i < contactsCount; i++)
        {
            ABRecordRef record = (__bridge ABRecordRef)[contacts objectAtIndex:i];
            
            AddressBookObj * addressBookObj = [[AddressBookObj alloc] init];
            
            //取得联系人的ID
            addressBookObj.recordID = (int)ABRecordGetRecordID(record);
            
            //完整姓名
            CFStringRef compositeNameRef = ABRecordCopyCompositeName(record);
            addressBookObj.compositeName = SafeString((__bridge NSString *)compositeNameRef);
            compositeNameRef != NULL ? CFRelease(compositeNameRef) : NULL;
            
            
            
            //处理联系人电话号码
            ABMultiValueRef  phones = ABRecordCopyValue(record, kABPersonPhoneProperty);
            for(int i = 0; i < ABMultiValueGetCount(phones); i++)
            {
                CFStringRef phoneLabelRef = ABMultiValueCopyLabelAtIndex(phones, i);
                CFStringRef localizedPhoneLabelRef = ABAddressBookCopyLocalizedLabel(phoneLabelRef);
                CFStringRef phoneNumberRef = ABMultiValueCopyValueAtIndex(phones, i);
                
                NSString * localizedPhoneLabel = (__bridge NSString *) localizedPhoneLabelRef;
                NSString * phoneNumber = (__bridge NSString *)phoneNumberRef;
                
                
                NSString *phone = [phoneNumber stringByReplacingOccurrencesOfString:@"[^0-9]" withString:@"" options:NSRegularExpressionSearch range:NSMakeRange(0, [phoneNumber length])];
                
                if (i == 0) {
                    addressBookObj.pbone = SafeString(phone);
                }
                [addressBookObj.phoneInfo setValue:localizedPhoneLabel forKey:phone];
                
                //Release
                phoneLabelRef == NULL ? : CFRelease(phoneLabelRef);
                localizedPhoneLabelRef == NULL ? : CFRelease(localizedPhoneLabelRef);
                phoneNumberRef == NULL ? : CFRelease(phoneNumberRef);
            }
            if(phones != NULL) CFRelease(phones);
            
            
            if (IsSafeString(addressBookObj.pbone)) {
                [_addressBooksArr addObject:addressBookObj];
            }
            
            CFRelease(record);
        }
    }
    
    return _addressBooksArr;
}


+(NSMutableArray*)addressBooks{
    
    return [AddressBook sharedAddressBook].addressBooksArr;
    
}


+(BOOL)containPhoneNum:(NSString*)phoneNum{
    
    for (AddressBookObj *obj in [AddressBook sharedAddressBook].addressBooksArr) {
        
        return [obj.phoneInfo[phoneNum] boolValue];
        
    }
    return NO;
}
@end

