//
//  CXConst.h
//  UPloadVideo
//
//  Created by 李霆 on 2018/10/16.
//  Copyright © 2018年 123. All rights reserved.
//

#import <UIKit/UIKit.h>
/*** 定位纬度 ****/
extern float NowLatitude;
/*** 定位经度 ****/
extern float NowLongitude;
/*** 定位位置 ****/
extern NSString *NowAddress;
/** 通用的间距值 */
UIKIT_EXTERN CGFloat const CXMargin;
/** 通用的小间距值 */
UIKIT_EXTERN CGFloat const CXSmallMargin;
/** 时间姓名字号 */
UIKIT_EXTERN CGFloat const CXSmallFont;
/** 描述文字字号 */
UIKIT_EXTERN CGFloat const CXToBigFont;

/*** 仅限于待审核控制器使用,在view层级,审核,推荐,拒绝成功后的通知,目的是回控制器删除相应的数据 ****/
UIKIT_EXTERN NSString * const operateSuccessfullyNotification;
/*** 上面通知传值的key ****/
UIKIT_EXTERN NSString * const sussessKey;

/** 成功code */
UIKIT_EXTERN int const CodeSussess;

