//
//  AppDelegate.m
//  UPloadVideo
//
//  Created by qiaowa on 2018/9/15.
//  Copyright © 2018年 123. All rights reserved.
//

#import "AppDelegate.h"
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>
#endif
// 如果需要使用 idfa 功能所需要引入的头文件（可选）
#import <AdSupport/AdSupport.h>

@interface AppDelegate ()<AMapLocationManagerDelegate>

/*** <#注释内容#> ****/
@property(nonatomic,strong) AMapLocationManager *locationManager;
/*** <#注释内容#> ****/
@property(nonatomic,strong) CLLocationManager *cllManager;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [self launchBaseView];
    [self dingWei];
    return YES;
}

- (void) launchBaseView
{
    self.window = [[UIWindow alloc]initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    CXMainViewController *maintabbar = [[CXMainViewController alloc]init];
    self.mainTabController = maintabbar;
    self.window.rootViewController = maintabbar;
    [self.window makeKeyAndVisible];
}


- (void)dingWei{
    
    self.cllManager =[[CLLocationManager alloc]init];
    if([[[UIDevice currentDevice] systemVersion] floatValue]>=8.0){
        [self.cllManager requestWhenInUseAuthorization];
    }
    //定位功能可用，开始定位
    [AMapServices sharedServices].apiKey = GDAppKey;
    self.locationManager = [[AMapLocationManager alloc] init];
//    [CLLocationManager authorizationStatus] == kCLAuthorizationStatusNotDetermined;
    self.locationManager.delegate = self;
    [self.locationManager setLocatingWithReGeocode:YES];
    
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    self.locationManager.distanceFilter = 200;
    self.locationManager.locationTimeout = 2;
    [self.locationManager startUpdatingLocation];
}

- (void)amapLocationManager:(AMapLocationManager *)manager didUpdateLocation:(CLLocation *)location reGeocode:(AMapLocationReGeocode *)reGeocode{
    NowLatitude = location.coordinate.latitude;
    NowLongitude = location.coordinate.longitude;
    if (reGeocode){
        /*** 具体的地址 ****/
        NowAddress = reGeocode.formattedAddress;
    }
}


- (void)application:(UIApplication *)application
    didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    
    
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    
}



@end
