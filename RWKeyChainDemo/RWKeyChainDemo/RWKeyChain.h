//
//  RWKeyChain.h
//  4444
//
//  Created by ru on 2017/4/21.
//  Copyright © 2017年 GMJK. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RWKeyChain : NSObject


/** 读取信息 */
+ (id)rw_readDataForKey:(NSString *)key;


/** 保存信息 */
+ (void)rw_saveData:(id)data   ForKey:(NSString *)key;


/** 删除信息 */
+ (void)rw_delegateData:(id)data   ForKey:(NSString *)key;



@end
