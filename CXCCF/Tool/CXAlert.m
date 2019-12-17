//
//  CXAlert.m
//  CarMessage
//
//  Created by 李霆 on 2018/5/18.
//  Copyright © 2018年 车讯. All rights reserved.
//

#import "CXAlert.h"

@implementation CXAlert
//提示信息
+ (void)showMessage:(NSString *)message andTrueoOrFalse:(BOOL )states Time:(double)time{
    if (message.length == 0) {
        return;
    }
    // 获取window
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    UIView *showView = [[UIView alloc] init];
    showView.backgroundColor = RGBColor(51,51,51);
    showView.frame = CGRectMake(1, 1, 1, 1);
    showView.alpha = 1.0f;
    showView.layer.cornerRadius = 6.0f;
    showView.layer.masksToBounds = YES;
    [window addSubview:showView];
    showView.frame = CGRectMake(kScreenWidth/2-150*WidthScale, kScreenHeight/2-100*WidthScale, 300*WidthScale, 200*WidthScale);
    UIImageView *imaView = [[UIImageView alloc]initWithFrame:CGRectMake(120*WidthScale, 40*HeightScale, 60*WidthScale, 60*WidthScale)];
    if (states == YES) {
        imaView.image = Image(@"collection_tishi_true");
    }else{
        imaView.image = Image(@"collection_tishi_flas");
    }
    [showView addSubview:imaView];
    
    UILabel *label = [[UILabel alloc] init];
    label.text = message;
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont systemFontOfSize:15];
    label.textAlignment = NSTextAlignmentCenter;
    label.backgroundColor = [UIColor clearColor];
    [showView addSubview:label];
    label.frame = CGRectMake(0, imaView.lt_bottom+10*HeightScale, 300*WidthScale, 80*HeightScale);
    label.numberOfLines = 0;
    
    
    double t = time>0?time:2;
    [UIView animateWithDuration:t animations:^{
        showView.alpha = 0;
    } completion:^(BOOL finished) {
        [showView removeFromSuperview];
        
    }];
}
+ (void)showCenterMessage:(NSString *)message Time:(double)time {
    if (message.length == 0) {
        return;
    }
    // 获取window
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    UIView *showView = [[UIView alloc] init];
    showView.backgroundColor = RGBColor(51,51,51);
    showView.frame = CGRectMake(1, 1, 1, 1);
    showView.alpha = 1.0f;
    showView.layer.cornerRadius = 5.0f;
    showView.layer.masksToBounds = YES;
    [window addSubview:showView];
    
    UILabel *label = [[UILabel alloc] init];
    UIFont *font = [UIFont systemFontOfSize:15];
    CGRect labelRect = [message boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, 30) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: font} context:nil];
    label.frame = CGRectMake(10, 5, ceil(CGRectGetWidth(labelRect)), CGRectGetHeight(labelRect));
    label.text = message;
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont systemFontOfSize:15];
    label.textAlignment = NSTextAlignmentCenter;
    label.backgroundColor = [UIColor clearColor];
    [showView addSubview:label];
    showView.frame = CGRectMake((kScreenWidth - CGRectGetWidth(labelRect) - 20)/2, kScreenHeight/2-47, CGRectGetWidth(labelRect)+20, CGRectGetHeight(labelRect)+10);
    double t = time>0?time:2;
    [UIView animateWithDuration:t animations:^{
        showView.alpha = 0;
    } completion:^(BOOL finished) {
        [showView removeFromSuperview];
        
    }];
}

+(void)collectionCenterMessage:(NSString *)message Time:(double)time{
    // 获取window
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    UIView *showView = [[UIView alloc] init];
    showView.backgroundColor = RGBColor(51,51,51);
    showView.frame = CGRectMake(1, 1, 1, 1);
    showView.alpha = 1.0f;
    showView.layer.cornerRadius = 5.0f;
    showView.layer.masksToBounds = YES;
    [window addSubview:showView];
    
    UILabel *label = [[UILabel alloc] init];
    UIFont *font = [UIFont systemFontOfSize:15];
    CGRect labelRect = [message boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, 30) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: font} context:nil];
    label.frame = CGRectMake(10, 5, ceil(CGRectGetWidth(labelRect)), CGRectGetHeight(labelRect));
    label.text = message;
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont systemFontOfSize:15];
    label.textAlignment = NSTextAlignmentCenter;
    label.backgroundColor = [UIColor clearColor];
    [showView addSubview:label];
    showView.frame = CGRectMake((kScreenWidth - CGRectGetWidth(labelRect) - 20)/2, kScreenHeight-120, CGRectGetWidth(labelRect)+20, CGRectGetHeight(labelRect)+10);
    double t = time>0?time:2;
    [UIView animateWithDuration:t animations:^{
        showView.alpha = 0;
    } completion:^(BOOL finished) {
        [showView removeFromSuperview];
        
    }];
}
    


@end
