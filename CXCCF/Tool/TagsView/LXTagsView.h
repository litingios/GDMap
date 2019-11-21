//
//  LXTagsView.h
//  TestDemo
//
//  Created by 万众创新 on 2018/7/25.
//  Copyright © 2018年 万众创新. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Masonry.h"
#import "UIButton+LXExpandBtn.h"
#import "NSString+Extension.h"
#import "UIColor+LXExpand.h"

typedef void(^LXTagClick)(NSMutableArray *tagTitle);
@interface LXTagsView : UIView
/*
 * 标签数组
 */
@property (nonatomic ,strong)NSMutableArray *dataA;

/*
 * 回调
 */
@property (nonatomic ,copy)LXTagClick tagClick;
@end
