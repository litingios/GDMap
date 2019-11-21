//
//  CustomAnnotationView.h
//  CXCCF
//
//  Created by 李霆 on 2019/11/19.
//  Copyright © 2019 CX. All rights reserved.
//

#import <MAMapKit/MAMapKit.h>
#import "CustomCalloutView.h"

NS_ASSUME_NONNULL_BEGIN

@interface CustomAnnotationView : MAAnnotationView

@property (nonatomic, strong, readwrite) CustomCalloutView *calloutView;
@property(nonatomic,strong) MapModel *model;
/*** 点击气泡的回调方法 ****/
@property(nonatomic,copy) void(^btnCiledblock)(MapModel *model);

@end

NS_ASSUME_NONNULL_END
