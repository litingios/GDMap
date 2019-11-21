//
//  UIView+LTExtanslon.m
//  百思不得其解
//
//  Created by 李霆 on 2018/9/13.
//  Copyright © 2018年 李霆. All rights reserved.
//

#import "UIView+LTExtanslon.h"

@implementation UIView (LTExtanslon)

- (CGSize)lt_size
{
    return self.frame.size;
}

- (void)setLt_size:(CGSize)lt_size{
    CGRect frame = self.frame;
    frame.size = lt_size;
    self.frame = frame;
}

- (CGFloat)lt_width
{
    return self.frame.size.width;
}

- (CGFloat)lt_height
{
    return self.frame.size.height;
}

- (void)setLt_width:(CGFloat)lt_width
{
    CGRect frame = self.frame;
    frame.size.width = lt_width;
    self.frame = frame;
}

- (void)setLt_height:(CGFloat)lt_height
{
    CGRect frame = self.frame;
    frame.size.height = lt_height;
    self.frame = frame;
}

- (CGFloat)lt_x
{
    return self.frame.origin.x;
}

- (void)setLt_x:(CGFloat)lt_x
{
    CGRect frame = self.frame;
    frame.origin.x = lt_x;
    self.frame = frame;
}

- (CGFloat)lt_y
{
    return self.frame.origin.y;
}

- (void)setLt_y:(CGFloat)lt_y
{
    CGRect frame = self.frame;
    frame.origin.y = lt_y;
    self.frame = frame;
}

- (CGFloat)lt_centerX
{
    return self.center.x;
}

- (void)setLt_centerX:(CGFloat)lt_centerX
{
    CGPoint center = self.center;
    center.x = lt_centerX;
    self.center = center;
}

- (CGFloat)lt_centerY
{
    return self.center.y;
}

- (void)setLt_centerY:(CGFloat)lt_centerY
{
    CGPoint center = self.center;
    center.y = lt_centerY;
    self.center = center;
}

- (CGFloat)lt_right
{
    return CGRectGetMaxX(self.frame);
}

- (CGFloat)lt_bottom
{
    return CGRectGetMaxY(self.frame);
}

- (void)setLt_right:(CGFloat)lt_right
{
    self.lt_x = lt_right - self.lt_width;
}

- (void)setLt_bottom:(CGFloat)lt_bottom
{
    self.lt_y = lt_bottom - self.lt_height;
}

+ (instancetype)viewFromXib
{
    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil].lastObject;
}

- (BOOL)intersectWithView:(UIView *)view
{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    CGRect selfRect = [self convertRect:self.bounds toView:window];
    CGRect viewRect = [view convertRect:view.bounds toView:window];
    return CGRectIntersectsRect(selfRect, viewRect);
}

@end
