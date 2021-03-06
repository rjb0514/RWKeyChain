//
//  RWKeyChain.m
//  4444
//
//  Created by ru on 2017/4/21.
//  Copyright © 2017年 GMJK. All rights reserved.
//

#import "RWKeyChain.h"
#import <Security/Security.h>

@implementation RWKeyChain



/**
 查询钥匙串
 */
+ (NSMutableDictionary *)getKeychainQuery:(NSString *)key {
    
    return [NSMutableDictionary dictionaryWithObjectsAndKeys:
            (id)kSecClassGenericPassword,(id)kSecClass,
            key, (id)kSecAttrService,
            key, (id)kSecAttrAccount,
            (id)kSecAttrAccessibleAfterFirstUnlock,(id)kSecAttrAccessible, nil];
    
}


/** 读取信息 */
+ (id)rw_readDataForKey:(NSString *)key {
    
    id ret = nil;
    NSMutableDictionary *keychainQuery = [self getKeychainQuery:key];
    
    //Configure the search setting
    //Since in our simple case we are expecting only a single attribute to be returned (the password) we can set the attribute kSecReturnData to kCFBooleanTrue
    [keychainQuery setObject:(id)kCFBooleanTrue forKey:(id)kSecReturnData];
    [keychainQuery setObject:(id)kSecMatchLimitOne forKey:(id)kSecMatchLimit];
    
    CFDataRef keyData = NULL;
    
    if (SecItemCopyMatching((CFDictionaryRef)keychainQuery, (CFTypeRef *)&keyData) == noErr) {
        @try {
            ret = [NSKeyedUnarchiver unarchiveObjectWithData:(__bridge NSData *)keyData];
        } @catch (NSException *e) {
            NSLog(@"存储失败，key-- %@  exception-- %@", key, e);
        } @finally {
        }
    }
    
    if (keyData) {
        CFRelease(keyData);
    }
    
    return ret;
    
    return @"";
}


/** 保存信息 */
+ (void)rw_saveData:(id)data   ForKey:(NSString *)key {
    //获得keychain字典
    NSMutableDictionary *keychainQuery = [self getKeychainQuery:key];
    
    //删除旧值
    SecItemDelete((CFDictionaryRef)keychainQuery);
    
    //添加新值
    [keychainQuery setObject:[NSKeyedArchiver archivedDataWithRootObject:data] forKey:(id)kSecValueData];
    
    //    将新的信息添加到keychain中
    SecItemAdd((CFDictionaryRef)keychainQuery, NULL);
    
}


/** 删除信息 */
+ (void)rw_delegateData:(id)data   ForKey:(NSString *)key {
    
    NSMutableDictionary *keychainQuery = [self getKeychainQuery:key];
    SecItemDelete((CFDictionaryRef)keychainQuery);
    
}

@end
