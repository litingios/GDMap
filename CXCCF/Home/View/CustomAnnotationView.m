//
//  CustomAnnotationView.m
//  CXCCF
//
//  Created by 李霆 on 2019/11/19.
//  Copyright © 2019 CX. All rights reserved.
//

#import "CustomAnnotationView.h"

@implementation CustomAnnotationView

#define kCalloutWidth       200.0
#define kCalloutHeight      70.0

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    if (self.selected == selected)
    {
        return;
    }
    
    if (selected)
    {
        if (self.calloutView == nil)
        {
            self.calloutView = [[CustomCalloutView alloc] initWithFrame:CGRectMake(0, 0, kCalloutWidth, kCalloutHeight)];
            self.calloutView.center = CGPointMake(CGRectGetWidth(self.bounds) / 2.f + self.calloutOffset.x,-CGRectGetHeight(self.calloutView.bounds) / 2.f + self.calloutOffset.y);
            
        }
        self.calloutView.model = self.model;
        __weakSelf
        self.calloutView.btnCiledblock = ^(MapModel * _Nonnull model) {
            if (weakSelf.btnCiledblock) {
                weakSelf.btnCiledblock(weakSelf.model);
            }
        };
        [self addSubview:self.calloutView];
    }
    else
    {
        [self.calloutView removeFromSuperview];
    }
    
    [super setSelected:selected animated:animated];
}


/*
 在使用高德地图sdk开发的时候,需要自定义气泡吹出框,发现气泡添加的点击事件或者button都没响应
 原因:自定义的气泡是添加到大头针上的，而大头针的size只有下面很小一部分，所以calloutView是在大头针的外面的。
 而 iOS 按钮超过父视图范围是无法响应事件的处理方法。
 在CustomAnnotationView.m中重写hittest方法:
 */
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {

    UIView *view = [super hitTest:point withEvent:event];

    if (view == nil) {

        CGPoint tempoint = [self.calloutView.btn convertPoint:point fromView:self];
        if (CGRectContainsPoint(self.calloutView.btn.bounds, tempoint))

        {
            view = self.calloutView.btn;
        }
    }
    return view;
}


- (void)setModel:(MapModel *)model{
    _model = model;
}

@end
