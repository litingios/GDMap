//
//  CustomCalloutView.h
//  CXCCF
//
//  Created by 李霆 on 2019/11/19.
//  Copyright © 2019 CX. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CustomCalloutView : UIView

/*** <#注释内容#> ****/
@property(nonatomic,strong) MapModel *model;
/*** <#注释内容#> ****/
@property(nonatomic,strong) UIButton *btn;

/*** 点击气泡的回调方法 ****/
@property(nonatomic,copy) void(^btnCiledblock)(MapModel *model);


@end

NS_ASSUME_NONNULL_END
