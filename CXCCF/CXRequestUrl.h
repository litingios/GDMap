//
//  CXRequestUrl.h
//  CXEVlookProject
//
//  Created by EDZ on 2018/3/29.
//  Copyright © 2018年 CXEVlook. All rights reserved.
//
// 接口地址
#ifndef CXRequestUrl_h
#define CXRequestUrl_h

/*** 域名 ****/
//#define kNetAddress @"http://172.18.90.111:8889/" //测试
#define kNetAddress @"https://t1.jumayizhan.com/" //测试
//#define   kNetAddress  @"http://test.evlook.com/api/" //正式
/*** 接口 ****/
#define WXLoginUrl [kNetAddress stringByAppendingString:@"wxlogin"] //微信登录
#define WXCheckoutUrl [kNetAddress stringByAppendingString:@"getUserAuthInfo"] //验证是否是管理员
#define CheckListUrl [kNetAddress stringByAppendingString:@"getWordsListByCategoryIdAndTopicId"] //审核列表接口
#define WorkRelatedRingUrl [kNetAddress stringByAppendingString:@"updateClubWorks"] //作品关联车圈接口
#define CheckStatesUrl [kNetAddress stringByAppendingString:@"updateWorksCheckStatus"] //审核状态接口
#define RecommendUrl [kNetAddress stringByAppendingString:@"recommendWorks"] //推荐
#define CheckCategorysUrl [kNetAddress stringByAppendingString:@"getCategorys"] //审核获取分组接口
#define CheckTopicUrl [kNetAddress stringByAppendingString:@"miniAppActivityApi?type=2"] //审核获取话题接口
#define GetCarCircleUrl [kNetAddress stringByAppendingString:@"getAllClubSeriesAPI"] //获取车圈接口
#define CarXunBrandUrl @"http://api.tool.chexun.com/pc/downBrandInfo.do" //车讯获取品牌接口
#define CarXunCompanyUrl @"http://api.tool.chexun.com/pc/downCompanyInfo.do" //车讯获取厂商接口
#define CarXunSeriesUrl @"http://api.tool.chexun.com/pc/downSeriesInfo.do" //车讯获取车系接口
#define CheckLevelsUrl [kNetAddress stringByAppendingString:@"getAllCarClubsApi?level=0"] //筛选levels
#define EVBrandUrl @"http://www.evzhidao.com/api/car/brands.json" //EV获取品牌接口
#define EVCompanyAndSeriesUrl @"http://www.evzhidao.com/api/car/seriesOfBrand.json" //EV获取厂商和车系接口
#define ImageFroUrl [kNetAddress stringByAppendingString:@"appPicUploadApi"] //图片转url接口
#define AddCarCircleUrl [kNetAddress stringByAppendingString:@"addCarClubApi"] //创建车圈接口
#define LatestVersionUrl @"https://t1.jumayizhan.com/latestVersion?type=1&appCode=311" // 获取最新版本接口
#define GetNotAuditCountUrl @"checkeWorks" // 获取未审核数
#define GetPlAllCountCountUrl @"getSingleVideokWorksCount" // 获取评论数
#define GetPlListUrl @"getSingleVideokWorks" // 获取作品列表
#define GetPlDetalListUrl @"miniAppAllCommentList" // 获取评论详情
#define commentSubmitByAppUrl [kNetAddress stringByAppendingString:@"commentSubmitByApp"] // 提交评论
#endif /* CXRequestUrl_h */
