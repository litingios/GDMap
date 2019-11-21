//
//  DiZhiModel.m
//  CXCCF
//
//  Created by 李霆 on 2019/4/11.
//  Copyright © 2019年 CX. All rights reserved.
//

#import "DiZhiModel.h"

@implementation DiZhiModel

CGFloat latitude;

+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{@"latitude":@"lat",@"longitude":@"lng"};
}

@end
