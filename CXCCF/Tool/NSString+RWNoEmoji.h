//
//  NSString+RWNoEmoji.h
//  RunwuProject
//
//  Created by qiaowa on 2017/10/19.
//  Copyright © 2017年 qiaowandong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (RWNoEmoji)
// 检查字符串是否包含emoji表情
- (BOOL)containsEmoji;
- (NSMutableString *)removedEmojiString;
@end
