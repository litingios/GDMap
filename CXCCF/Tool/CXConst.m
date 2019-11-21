//
//  CXConst.m
//  UPloadVideo
//
//  Created by 李霆 on 2018/10/16.
//  Copyright © 2018年 123. All rights reserved.
//

#import <UIKit/UIKit.h>

/*** 定位纬度 ****/
float NowLatitude;
/*** 定位经度 ****/
float NowLongitude;
/*** 定位位置 ****/
NSString *NowAddress;

/** 通用的间距值 */
CGFloat const CXMargin = 10;
/** 通用的小间距值 */
CGFloat const CXSmallMargin = CXMargin * 0.5;
/** 时间姓名字号 */
CGFloat const CXSmallFont = 14;
/*** 描述文字字号 ****/
CGFloat const CXToBigFont = 15;

/*** 仅限于待审核控制器使用,在view层级,审核,推荐,拒绝成功后的通知,目的是回控制器删除相应的数据 ****/
NSString * const operateSuccessfullyNotification = @"operateSuccessfullyNotification";
/*** 上面通知传值的key ****/
NSString * const sussessKey = @"sussessKey";

/** 成功code */
int const CodeSussess = 100200;


