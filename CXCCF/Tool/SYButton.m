//
//  SYButton.m
//  20180824
//
//  Created by ZSY on 2018/8/24.
//  Copyright © 2018年 ZSY. All rights reserved.
//

#import "SYButton.h"


@implementation SYButton

- (void)layoutSubviews {
    [super layoutSubviews];
    [self.titleLabel sizeToFit];
    CGRect titleFrame = self.titleLabel.frame;
    CGRect imageFrame = self.imageView.frame;
    CGFloat spacing = 0;
    if (self.btnType == TOP || self.btnType == BOTTOM) {
        spacing = (self.frame.size.height - titleFrame.size.height - imageFrame.size.height - 5) / 2;
    } else {
        spacing = (self.frame.size.width - titleFrame.size.width - imageFrame.size.width - 5) / 2;
    }
    
    switch (self.btnType) {
        case TOP:
        {
            self.imageView.center = CGPointMake(self.frame.size.width / 2, spacing + imageFrame.size.height / 2);
            self.titleLabel.center = CGPointMake(self.frame.size.width / 2, CGRectGetMaxY(self.imageView.frame) + titleFrame.size.height / 2 + 5);
        }
            break;
        case BOTTOM:
        {
            self.titleLabel.center = CGPointMake(self.frame.size.width / 2, spacing + titleFrame.size.height / 2);
            self.imageView.center = CGPointMake(self.frame.size.width / 2, CGRectGetMaxY(self.titleLabel.frame) + imageFrame.size.height / 2 + 5);
        }
            break;
        case LEFT:
        {
            self.imageView.center = CGPointMake(spacing + imageFrame.size.width / 2, self.frame.size.height / 2);
            self.titleLabel.center = CGPointMake(CGRectGetMaxX(self.imageView.frame) + 5 + titleFrame.size.width / 2, self.frame.size.height / 2);
        }
            break;
        case RIGHT:
        {
            self.titleLabel.center = CGPointMake(spacing + titleFrame.size.width / 2, self.frame.size.height / 2);
            self.imageView.center = CGPointMake(CGRectGetMaxX(self.titleLabel.frame) + 5 + imageFrame.size.width / 2, self.frame.size.height / 2);
        }
            break;
        default:
            break;
    }
}

@end
