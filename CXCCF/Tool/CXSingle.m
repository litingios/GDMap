//
//  CXSingle.m
//  CXEVlookProject
//
//  Created by EDZ on 2018/3/29.
//  Copyright © 2018年 CXEVlook. All rights reserved.
//

#import "CXSingle.h"

@implementation CXSingle

// 1.设置静态的对象
static CXSingle *single = nil;

+ (CXSingle *)shareSingleMethod {
    
    // 2.线程安全，这样的创建只有一个线程进入，只能创建一个对象
    @synchronized(self) {
        
        single = [[CXSingle alloc] init];
    }
    return single;
}
// 为了保证对象的唯一性，重写allocwithzone方法
+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    
    if (single == nil) {
        
        single = [super allocWithZone:zone];
    }
    return single;
}
// 释放对象
+ (void)releaseSingle {
    
    if (single != nil) {
        
        single = nil;
    }
}
//  初始化
- (instancetype)init {
    
    if (self = [super init]) {
        
        self.defaults = [NSUserDefaults standardUserDefaults];
        self.token = [self getString:[_defaults objectForKey:@"token"]];
        self.cityCode = [self getString:[_defaults objectForKey:@"cityCode"]];
    }
    return self;
    
}
- (NSString *)getString:(id)object {
    
    NSString * string = [NSString stringWithFormat:@"%@",object];
    if (!string || [string isEqualToString:@"null"] || [string isEqualToString:@"(null)"] || [string isEqualToString:@""]) {
        
        string = @"";
        
    }
    return string;
}
- (void)setCityCode:(NSString *)cityCode {
    
    if (cityCode != _cityCode && cityCode) {
        
        _cityCode = [cityCode copy];
        [_defaults setObject:[self getString:_cityCode] forKey:@"cityCode"];
        
    }else if(!cityCode) {
        
        _cityCode = nil;
        [_defaults setObject:@"" forKey:@"cityCode"];
    }
    
    [_defaults synchronize];
    
}

- (void)setToken:(NSString *)token {
    
    if (token != _token && token) {
        
        _token = [token copy];
        [_defaults setObject:[self getString:_token] forKey:@"token"];
        
    }else if(!token) {
        
        _token = nil;
        [_defaults setObject:@"" forKey:@"token"];
    }
    
    [_defaults synchronize];
    
}
@end
