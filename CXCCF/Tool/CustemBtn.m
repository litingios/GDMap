//
//  CustemBtn.m
//  CNP_AIWIFI
//
//  Created by qiaowa on 2016/12/27.
//  Copyright © 2016年 WJ. All rights reserved.
//

#import "CustemBtn.h"

@implementation CustemBtn

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.titleLabel.font = [Custom systemFont:10];
        [self setTitleColor:HexColor(@"0x4a4a4a") forState:UIControlStateNormal];
        //        self.contentHorizontalAlignment = UIControlContentHorizontalAlignmen;
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.imageView.contentMode = UIViewContentModeBottom;
        
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self setTitleColor:HexColor(@"0x4a4a4a") forState:UIControlStateNormal];
        //        hex = UIControlContentHorizontalAlignmen;
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.imageView.contentMode = UIViewContentModeCenter;
    }
    return self;
}
-(CGRect)titleRectForContentRect:(CGRect)contentRect{
    CGFloat x = 0;
    CGFloat y = self.frame.size.height*0.5;
    CGFloat w = self.frame.size.width;
    CGFloat h = self.frame.size.height*0.5;
    return CGRectMake(x, y , w, h);
}

-(CGRect)imageRectForContentRect:(CGRect)contentRect{
    
    CGFloat x = 0;
    CGFloat y = 0;
    CGFloat w = self.frame.size.width;
    CGFloat h = self.frame.size.height*.6;
    return CGRectMake(x, y , w, h);
}

@end
