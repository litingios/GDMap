//
//  SYButton.h
//  20180824
//
//  Created by ZSY on 2018/8/24.
//  Copyright © 2018年 ZSY. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger) {
    TOP     = 0, // 上
    LEFT    = 1, // 左
    BOTTOM  = 2, // 下
    RIGHT   = 3  // 右
}BtnType;

@interface SYButton : UIButton
@property (nonatomic, assign) BtnType btnType;
@end
