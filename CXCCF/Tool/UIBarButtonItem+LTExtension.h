//
//  UIBarButtonItem+LTExtension.h
//  百思不得其解
//
//  Created by 李霆 on 2018/9/14.
//  Copyright © 2018年 李霆. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (LTExtension)


/**
 
 @param image 正常状态下图片
 @param highImage 高亮状态下的图片
 @param target 对象
 @param action 点击事件
 @return 对象
 */
+ (instancetype)itemWithImage:(NSString *)image highImage:(NSString *)highImage target:(id)target action:(SEL)action;


/**

 @param title 显示文字
 @param normalColor 正常状态的文字颜色
 @param highlightedColor 高亮文字颜色
 @param target 对象
 @param action 事件
 @return 对象
 */
+ (instancetype)itemWithTitle:(NSString *)title normal:(UIColor *)normalColor Highlighted:(UIColor *)highlightedColor target:(id)target action:(SEL)action;

@end
