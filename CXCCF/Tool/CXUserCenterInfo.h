//
//  CXUserCenterInfo.h
//  UPloadVideo
//
//  Created by 李霆 on 2018/10/15.
//  Copyright © 2018年 123. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CXUserCenterInfo;
extern CXUserCenterInfo *myUserInfo;

@interface CXUserCenterInfo : NSObject<NSCoding>

/*** 姓名 ****/
@property(nonatomic,copy) NSString *nickName;
/*** 性别 ****/
@property(nonatomic,copy) NSString *sex;
/*** 头像 ****/
@property(nonatomic,copy) NSString *userAvatar;
/*** token ****/
@property(nonatomic,copy) NSString *userToken;

#pragma mark 获得单例个人中心信息
+(id)shareUsrcenterInfo;
#pragma mark 存储路径
+(NSString *)SavePath;
#pragma mark 归档模型对象
+(void)archiveObject:(CXUserCenterInfo *)user;
#pragma mark 读取模型对象
+(CXUserCenterInfo *)unarchiveObject;

@end
