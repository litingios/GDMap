//
//  CXSingle.h
//  CXEVlookProject
//
//  Created by EDZ on 2018/3/29.
//  Copyright © 2018年 CXEVlook. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 单利
 */
@interface CXSingle : NSObject

@property (nonatomic,copy) NSString *token; // token
@property (nonatomic,copy) NSString *cityCode; // token

@property (nonatomic, retain) NSUserDefaults *defaults; // 同步到文件

/**
 通过类方法得到这个类
 
 @return 类
 */
+ (CXSingle *)shareSingleMethod;

/**
 释放对象
 */
+ (void)releaseSingle;

@end
