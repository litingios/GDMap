//
//  NSString+RWNoEmoji.m
//  RunwuProject
//
//  Created by qiaowa on 2017/10/19.
//  Copyright © 2017年 qiaowandong. All rights reserved.
//

#import "NSString+RWNoEmoji.h"

@implementation NSString (RWNoEmoji)
// 检查字符串是否包含emoji
- (BOOL)containsEmoji
{
    __block BOOL contain = NO;
    [self enumerateSubstringsInRange:NSMakeRange(0, self.length) options:NSStringEnumerationByComposedCharacterSequences usingBlock:^(NSString * _Nullable substring, NSRange substringRange, NSRange enclosingRange, BOOL * _Nonnull stop) {
        if ([substring isEmoji]) {
            contain = YES;
            *stop = YES;
        }
    }];
    
    return contain;
}
- (NSMutableString *)removedEmojiString {
    NSMutableString* __block buffer = [NSMutableString stringWithCapacity:[self length]];
    
    [self enumerateSubstringsInRange:NSMakeRange(0, [self length])
                             options:NSStringEnumerationByComposedCharacterSequences
                          usingBlock: ^(NSString* substring, NSRange substringRange, NSRange enclosingRange, BOOL* stop) {
                              
                              [buffer appendString:([substring isEmoji])? @"": substring];
                              
                          }];
    
    return buffer;
}
// 检查一个‘字符’是否是emoji表情
- (BOOL)isEmoji
{
    if (self.length <= 0) {
        return NO;
    }
    unichar first = [self characterAtIndex:0];
    switch (self.length) {
        case 1:
        {
            if (first == 0xa9 || first == 0xae || first == 0x2122 ||
                first == 0x3030 || (first >= 0x25b6 && first <= 0x27bf) ||
                first == 0x2328 || (first >= 0x23e9 && first <= 0x23fa)) {
                return YES;
            }
        }
            break;
            
        case 2:
        {
            unichar c = [self characterAtIndex:1];
            if (c == 0xfe0f) {
                if (first >= 0x203c && first <= 0x3299) {
                    return YES;
                }
            }
            if (first >= 0xd83c && first <= 0xd83e) {
                return YES;
            }
        }
            break;
            
        case 3:
        {
            unichar c = [self characterAtIndex:1];
            if (c == 0xfe0f) {
                if (first >= 0x23 && first <= 0x39) {
                    return YES;
                }
            }
            else if (c == 0xd83c) {
                if (first == 0x26f9 || first == 0x261d || (first >= 0x270a && first <= 0x270d)) {
                    return YES;
                }
            }
            if (first == 0xd83c) {
                return YES;
            }
        }
            break;
            
        case 4:
        {
            unichar c = [self characterAtIndex:1];
            if (c == 0xd83c) {
                if (first == 0x261d || first == 0x270c) {
                    return YES;
                }
            }
            if (first >= 0xd83c && first <= 0xd83e) {
                return YES;
            }
        }
            break;
            
        case 5:
        {
            if (first == 0xd83d) {
                return YES;
            }
        }
            break;
            
        case 8:
        case 11:
        {
            if (first == 0xd83d) {
                return YES;
            }
        }
            break;
            
        default:
            break;
    }
    
    return NO;
}
@end
