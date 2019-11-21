//
//  AFHTTPClient.h
//  HelloTest
//
//  Created by qiaowandong on 2016/10/17.
//  Copyright © 2016年 qiao. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import <CoreLocation/CoreLocation.h>
#import <CommonCrypto/CommonDigest.h>
#import <UIKit/UIKit.h>

#import <SystemConfiguration/CaptiveNetwork.h>
#include <ifaddrs.h> 
#include <arpa/inet.h>

#include <sys/sysctl.h>
#include <net/if.h>
#include <net/if_dl.h>
//#import "OutOfSeverVeiw.h"
//#import "UIDevice+IdentifierAddition.h"
#import "SearchBarText.h"



typedef NS_ENUM(NSUInteger, GradientType) {
    GradientTypeTopToBottom = 0,//从上到小
    GradientTypeLeftToRight = 1,//从左到右
    GradientTypeUpleftToLowright = 2,//左上到右下
    GradientTypeUprightToLowleft = 3,//右上到左下
};
typedef void(^labelSettingBlock)(UILabel * labelSetting);
@interface Custom : NSObject   {

}
+ (NSString *)timeFromTimestamp:(NSInteger)timestamp;
//电话去掉+86
+ (NSString *)formatPhoneNum:(NSString *)phone;
//电话验证
+ (BOOL)validateTelephoneNumber:(NSString *)telNum;
+ (NSString*)encodeString:(NSString*)unencodedString;
//提示框(只包含内容)
+ (void)messageWithString:(NSString *)aString;
//提示框(标题加内容)
+ (void)messageWithString:(NSString *)aString title:(NSString *)title;
//读取plist文件
+ (NSMutableArray *)loadPlistName:(NSString *)name;
//设置边框
+ (void)setBorder:(UIView *)sender;
//设置阴影
+ (void)setShadow:(UIView *)sender;
//获取文件目录
+ (NSString *)getDocumentDir;
//获取临时文件目录
+ (NSString *)getTempDir;
+ (NSString *)iPhone5WithString:(NSString *)name;
//获取系统时间
+ (NSDate *)getSystemTime;
//时间戳转换时间
+ (NSString *)transformationTimeClock:(NSString *)timeInterval;
+ (NSString *)transformationTime:(NSString *)timeInterval;
+ (NSString *)transformationDate:(NSString *)timeInterval timestr:(NSString *)formatstr;
//换时间转时间戳
+ (NSString *)transformationTimeInterval:(NSDate *)time;
//MD5加密
+ (NSString *)MD5:(NSString *)str;
//图片截取
+ (UIImage *)reSizeImage:(UIImage *)image toSize:(CGSize)reSize;
//图片等比缩放
+ (UIImage *)scaleToSize:(UIImage *)image targetSize:(CGSize)size;
//图片文件大小压缩
+ (NSData *)compressOriginalImage:(UIImage *)image toMaxDataSizeKBytes:(CGFloat)size;
//字号
+ (UIFont *)systemFont:(CGFloat)size;
//字号加粗
+ (UIFont *)systemFontBold:(CGFloat)size;
//导航
+ (UINavigationController *)defaultNavigationController:(UIViewController *)rootViewController;
//color转image
+ (UIImage*) createImageWithColor: (UIColor*) color;
+(UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;
//用户手机连接的wifi的mac地址
+ (NSString *)getSystemWIFIMAC;
//登录ip
+ (NSString *)getSystemIP;
//UUID
+ (NSString *)getUUID;
+ (NSString *)getWIFIName;
//参数拼接加密
+ (NSString *)splicingAndEncryption:(NSDictionary *)dic;

//saveCach
+(void)saveCatche:(NSString *)type andData:(id)data;
+(id)JSONValue:(NSData *)data;
//navigation右边按钮
+ (UIButton *)creatNavigationRightBtnWithSel:(SEL)sel navigationItem:(UINavigationItem *)navigationitem Title:(NSString *)title Target:(id)target;

//根据日期获取星座
+ (NSString *)getAstroWithMonth:(int)m day:(int)d;

+(SearchBarText *)getSearchBar:(CGRect)rect cornerRadius:(CGFloat)cornerRadius text:(NSString *)text serachIcon:(NSString *)iconName enableText:(BOOL)enable;

//+(OutOfSeverVeiw *)addTipsView:(int)tips imgStr:(int)imgstr vc:(UIViewController *)vc;

//跑马灯效果
+ (UIView *)getPaoMaDengAnimation:(NSString *)string LabelBlock:(labelSettingBlock)block;
+(NSString *)reviseString:(NSString *)str;
//图片倒置
+ (UIImage *)fixOrientation:(UIImage *)aImage;
//获取版本号
+ (NSString *)getVersion;
//异步下载图片
+(void)LoadImageWithImageView:(UIImageView *)imageView url:(NSString *)url placeholder:(NSString *)name;
+(void)downLoadImageWithImageView:(UIImageView *)imageView url:(NSString *)url placeholder:(UIImage *)hodlerimage;
///view转image
+(UIImage*)convertViewToImage:(NSString *)title;
///渐变色
+ (UIImage *)gradientColorImageFromColors:(NSArray*)colors gradientType:(GradientType)gradientType imgSize:(CGSize)imgSize;
+(void)requestPages:(NSString *)pageName;

@end

