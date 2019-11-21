//
//  CXRichText.m
//  CXEVlookProject
//
//  Created by 李霆 on 2018/4/16.
//  Copyright © 2018年 CXEVlook. All rights reserved.
//

#import "CXRichText.h"

@implementation CXRichText

#pragma mark --------- 计算富文本的lable高度
+(CGFloat)getSpaceLabelHeight:(NSString*)str withFont:(UIFont*)font withWidth:(CGFloat)width withHangJu:(int)HangJu{
    if (str.length == 0) {
        return 0;
    }
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
    paraStyle.lineSpacing = HangJu;
    NSDictionary *dic = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paraStyle, NSKernAttributeName:@1.5f
                          };
    CGSize size = [str boundingRectWithSize:CGSizeMake(width, kScreenHeight) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
    return size.height;
}

#pragma mark --------- lable添加间距
+(void)setLable:(UILabel *)lable withHangJu:(int)HnagJu withString:(NSString*)str {
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    if (str.length == 0) {
        return;
    }
    // 行间距设置为30
    [paragraphStyle  setLineSpacing:HnagJu];
    NSMutableAttributedString  *setString = [[NSMutableAttributedString alloc] initWithString:str];
    [setString  addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [str length])];
    // 设置Label要显示的text
    [lable setAttributedText:setString];
}

#pragma mark --------- lable设置不同的颜色
+ (void)changeLableTextColorWithStr:(NSString *)titleStr withFont:(UIFont *)textFont withColor:(UIColor *)textColor withStartRange:(NSInteger )startRange withLength:(NSInteger)length withLable:(UILabel *)handleLable{
    if (titleStr.length == 0) {
        return;
    }
    NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc]initWithString:titleStr];
    [AttributedStr addAttribute:NSForegroundColorAttributeName
                          value:textColor
                          range:NSMakeRange(startRange, length)];
    [AttributedStr addAttribute:NSFontAttributeName
                          value:textFont
                          range:NSMakeRange(startRange, length)];
    handleLable.attributedText = AttributedStr;
}

#pragma mark --------- lable设置不同的字号
+ (void)changeLableTextFontWithStr:(NSString *)titleStr withFont:(UIFont *)textFont withStartRange:(NSInteger )startRange withLength:(NSInteger)length withLable:(UILabel *)handleLable{
    if (titleStr.length == 0) {
        return;
    }
    NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc]initWithString:titleStr];
    [AttributedStr addAttribute:NSFontAttributeName
                              value:textFont
                              range:NSMakeRange(startRange, length)];
    handleLable.attributedText = AttributedStr;
}

+ (CGFloat)computeLableHeightWithFont:(UIFont*)font withStr:(NSString *)str withWidth:(CGFloat)Width{
    NSDictionary *attributes = @{NSFontAttributeName:font};
    CGFloat length = [str boundingRectWithSize:CGSizeMake(Width, 2000) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size.height;
    return length;
}


@end
