//
//  CXRichText.h
//  CXEVlookProject
//
//  Created by 李霆 on 2018/4/16.
//  Copyright © 2018年 CXEVlook. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CXRichText : NSObject


/**
 *   设置行距
 */
+(void)setLable:(UILabel *)lable withHangJu:(int)HnagJu withString:(NSString*)str;

/**
 *   计算高度
 */
+(CGFloat)getSpaceLabelHeight:(NSString*)str withFont:(UIFont*)font withWidth:(CGFloat)width withHangJu:(int)HangJu;

/**
 *   设置颜色
 */
+ (void)changeLableTextColorWithStr:(NSString *)titleStr withFont:(UIFont *)textFont withColor:(UIColor *)textColor withStartRange:(NSInteger )startRange withLength:(NSInteger)length withLable:(UILabel *)handleLable;
/**
 *   设置字号
 */
+ (void)changeLableTextFontWithStr:(NSString *)titleStr withFont:(UIFont *)textFont withStartRange:(NSInteger )startRange withLength:(NSInteger)length withLable:(UILabel *)handleLable;
/**
 *   计算高度
 */
+ (CGFloat)computeLableHeightWithFont:(UIFont*)font withStr:(NSString *)str withWidth:(CGFloat)Width;


@end
