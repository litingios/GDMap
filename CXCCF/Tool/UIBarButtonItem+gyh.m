//
//  UIBarButtonItem+gyh.m
//  微博
//
//  Created by gyh on 15-3-9.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "UIBarButtonItem+gyh.h"


@implementation UIBarButtonItem (gyh)

+(UIBarButtonItem *)ItemWithnoedgeIcon:(NSString *)icon highIcon:(NSString *)highIcon target:(id)target action:(SEL)action
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:icon] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:highIcon] forState:UIControlStateHighlighted];
    button.frame = CGRectMake(0, 0, 50, 100);
    button.imageEdgeInsets = UIEdgeInsetsMake(0, 17, 0, -17);
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc]initWithCustomView:button];
}

//快速创建一个显示图片的item
+(UIBarButtonItem *)ItemWithIcon:(NSString *)icon highIcon:(NSString *)highIcon target:(id)target action:(SEL)action
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:icon] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:highIcon] forState:UIControlStateHighlighted];
    button.imageEdgeInsets = UIEdgeInsetsMake(0, -17, 0, 17);
    button.frame = CGRectMake(0, 0, 50, 100);
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc]initWithCustomView:button];
}


+(UIBarButtonItem *)ItemWithTitle:(NSString *)title titleColor:(UIColor*)color target:(id)target action:(SEL)action
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:title forState:UIControlStateNormal];
    button.frame = (CGRect){CGPointZero,40,30};
    button.titleLabel.font = [UIFont systemFontOfSize:14];
    [button setTitleColor:color forState:UIControlStateNormal];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc]initWithCustomView:button];
}

+(UIBarButtonItem *)rightItemWithTitle:(NSString *)title titleColor:(UIColor*)color target:(id)target action:(SEL)action
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:title forState:UIControlStateNormal];
    button.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, -10);
    button.frame = (CGRect){CGPointZero,40,30};
    button.titleLabel.font = [UIFont systemFontOfSize:14];
    [button setTitleColor:color forState:UIControlStateNormal];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc]initWithCustomView:button];
}


@end
