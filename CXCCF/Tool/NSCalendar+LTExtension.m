//
//  NSCalendar+LTExtension.m
//  百思不得姐
//
//  Created by 李霆 on 2018/9/26.
//  Copyright © 2018年 李霆. All rights reserved.
//

#import "NSCalendar+LTExtension.h"

@implementation NSCalendar (LTExtension)

+ (instancetype)calendar
{
    if ([NSCalendar respondsToSelector:@selector(calendarWithIdentifier:)]) {
        return [NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];
    } else {
        return [NSCalendar currentCalendar];
    }
}

@end
