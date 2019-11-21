//
//  UITabBar+Badge.h
//  CNP_AIWIFI
//
//  Created by qiaowa on 2017/2/28.
//  Copyright © 2017年 WJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITabBar (Badge)

- (void)showBadgeOnItemIndex:(int)index;   //显示小红点

- (void)hideBadgeOnItemIndex:(int)index; //隐藏小红点
@end
