//
//  CXUserCenterInfo.m
//  UPloadVideo
//
//  Created by 李霆 on 2018/10/15.
//  Copyright © 2018年 123. All rights reserved.
//

#import "CXUserCenterInfo.h"

CXUserCenterInfo *myUserInfo;

@implementation CXUserCenterInfo

+(id)shareUsrcenterInfo
{
    myUserInfo=[CXUserCenterInfo unarchiveObject];
    if(myUserInfo==nil){
        myUserInfo=[[CXUserCenterInfo alloc]init];
    }
    return myUserInfo;
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    NSLog(@"UserCenterInfo ====%@",key);
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [self mj_encode:aCoder];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if(self = [super init])
    {
        [self mj_decode:aDecoder];
    }
    return self;
}

+(NSString *)SavePath
{
    NSString * doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES)lastObject];
    // 获得Documents全路径
    NSString * path = [doc stringByAppendingPathComponent:@"userinfo"]; // 获取文件的全路径
    return path;
}

#pragma mark 归档模型对象
+(void)archiveObject:(CXUserCenterInfo *)user
{
    BOOL result = [NSKeyedArchiver  archiveRootObject:user toFile:[CXUserCenterInfo SavePath]]; // 将对象归档
    NSLog(@"归档===%d",result);
}

#pragma mark 读取模型对象
+(CXUserCenterInfo *)unarchiveObject
{
    return [NSKeyedUnarchiver  unarchiveObjectWithFile:[CXUserCenterInfo SavePath]];
}

@end
