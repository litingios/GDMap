//
//  SearchBarText.m
//  CNP_AIWIFI
//
//  Created by qiaowa on 2016/12/12.
//  Copyright © 2016年 WJ. All rights reserved.
//

#import "SearchBarText.h"

@implementation SearchBarText

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(id)initWithFrame:(CGRect)frame drawingLeft:(UIImageView *)icon{
    self = [super initWithFrame:frame];
    if (self) {
        self.leftView = icon;
        self.leftViewMode = UITextFieldViewModeAlways;
    }
    return self;
}


-(CGRect)leftViewRectForBounds:(CGRect)bounds{
    CGRect iconRect = [super leftViewRectForBounds:bounds];
    iconRect.origin.x += 10;// 右偏10
    return iconRect;
}

-(CGRect)textRectForBounds:(CGRect)bounds
{
    
    CGRect iconRect = [super textRectForBounds:bounds];
    iconRect.origin.x += 10;// 右偏10
    return iconRect;
    
}


- (CGRect)editingRectForBounds:(CGRect)bounds;
{
    CGRect iconRect = [super textRectForBounds:bounds];
    iconRect.origin.x += 10;// 右偏10
    return iconRect;
}

@end
