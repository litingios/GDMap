//
//  UIView+LTExtanslon.h
//  百思不得其解
//
//  Created by 李霆 on 2018/9/13.
//  Copyright © 2018年 李霆. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (LTExtanslon)

@property (nonatomic, assign) CGSize lt_size;
@property (nonatomic, assign) CGFloat lt_width;
@property (nonatomic, assign) CGFloat lt_height;
@property (nonatomic, assign) CGFloat lt_x;
@property (nonatomic, assign) CGFloat lt_y;
@property (nonatomic, assign) CGFloat lt_centerX;
@property (nonatomic, assign) CGFloat lt_centerY;
@property (nonatomic, assign) CGFloat lt_right;
@property (nonatomic, assign) CGFloat lt_bottom;

+ (instancetype)viewFromXib;

- (BOOL)intersectWithView:(UIView *)view;

@end
