//
//  DiZhiModel.h
//  CXCCF
//
//  Created by 李霆 on 2019/4/11.
//  Copyright © 2019年 CX. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DiZhiModel : NSObject

///POI全局唯一ID
@property (nonatomic, copy)   NSString     *uid;
///名称
@property (nonatomic, copy)   NSString     *name;
///兴趣点类型
@property (nonatomic, copy)   NSString     *type;
///类型编码
@property (nonatomic, copy)   NSString     *typecode;
///经纬度
@property (nonatomic, assign)   CGFloat latitude;
@property (nonatomic, assign)   CGFloat longitude;
//@property (nonatomic, copy)   NSString *lat;
//@property (nonatomic, copy)   NSString *lng;

/*** 下标 ****/
@property(nonatomic)NSInteger ltIndex;
///地址
@property (nonatomic, copy)   NSString     *address;
///电话
@property (nonatomic, copy)   NSString     *tel;
///距中心点的距离，单位米。在周边搜索时有效
@property (nonatomic, assign) NSInteger     distance;
///停车场类型，地上、地下、路边
@property (nonatomic, copy)   NSString     *parkingType;
///商铺id
@property (nonatomic, copy)   NSString     *shopID;

///邮编
@property (nonatomic, copy)   NSString     *postcode;
///网址
@property (nonatomic, copy)   NSString     *website;
///电子邮件
@property (nonatomic, copy)   NSString     *email;
///省
@property (nonatomic, copy)   NSString     *province;
///省编码
@property (nonatomic, copy)   NSString     *pcode;
///城市名称
@property (nonatomic, copy)   NSString     *city;
///城市编码
@property (nonatomic, copy)   NSString     *citycode;
///区域名称
@property (nonatomic, copy)   NSString     *district;
///区域编码
@property (nonatomic, copy)   NSString     *adcode;
///地理格ID
@property (nonatomic, copy)   NSString     *gridcode;
/*** id ****/
@property(nonatomic,copy) NSString *id;
/*** level ****/
@property(nonatomic,copy) NSString *level;
/*** pid ****/
@property(nonatomic,copy) NSString *pid;


@end

NS_ASSUME_NONNULL_END
