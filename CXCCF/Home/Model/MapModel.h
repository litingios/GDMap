//
//  MapModel.h
//  CXCCF
//
//  Created by 李霆 on 2019/11/18.
//  Copyright © 2019 CX. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MapModel : NSObject

/*** 名字 ****/
@property(nonatomic,copy) NSString *name;
/*** 经度 ****/
@property(nonatomic,assign) CGFloat lng;
/*** 纬度 ****/
@property(nonatomic,assign) CGFloat lat;
/*** code ****/
@property(nonatomic,copy) NSString *code;
/*** sa_id ****/
@property(nonatomic,copy) NSString *sa_id;
/*** 距离 ****/
@property(nonatomic,copy) NSString *distance;
/*** 是否在线上 ****/
@property(nonatomic,copy) NSString *in_line;
/*** district ****/
@property(nonatomic,copy) NSString *district;
/*** 是否有优惠活动 ****/
@property(nonatomic,copy) NSString *is_discount;
/*** 1高速2线下 ****/
@property(nonatomic,copy) NSString *station_type;
/*** 距离各条线段的距离 ****/
@property(nonatomic,copy) NSString *distances;
/*** 和悦 ****/
@property(nonatomic,copy) NSString *channel;

@property (nonatomic, assign) NSInteger zIndex;
/*** logo ****/
@property(nonatomic,copy) NSString *logo;
/*** 油站地址 ****/
@property(nonatomic,copy) NSString *address;

@end

NS_ASSUME_NONNULL_END
