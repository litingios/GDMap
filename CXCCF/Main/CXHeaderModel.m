//
//  CXHeaderModel.m
//  CXEVlookProject
//
//  Created by qiaowa on 2018/4/9.
//  Copyright © 2018年 CXEVlook. All rights reserved.
//

#import "CXHeaderModel.h"

@implementation CXHeaderModel

-(instancetype)init{
    self = [super init];
    if (self) {
//        self.userid = userManager.curUserInfo.userid;
//        self.imei = [OpenUDID value].length>32 ? [[OpenUDID value] substringToIndex:32] :[OpenUDID value];
//        self.os_type = 2;
        self.version = [Custom getVersion];
//        self.channel = @"App Store";
//        self.clientId = self.imei;//[OpenUDID value].length>32 ? [[OpenUDID value] substringToIndex:32] :[OpenUDID value];
//        self.versioncode = KVersionCode;
//        self.mobile_model = [UIDevice currentDevice].machineModelName;
//        self.mobile_brand = [UIDevice currentDevice].machineModel;
    }
    return self;
}
@end
