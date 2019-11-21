//
//  LTControl.h
//  百思不得其解
//
//  Created by 李霆 on 2018/9/15.
//  Copyright © 2018年 李霆. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LTControl : NSObject

//屏幕适配等比放大
+(CGRect)createCGRectMakeScale:(CGFloat)x andY:(CGFloat)y andWidth:(CGFloat)width andHeight:(CGFloat)height;
+(CGPoint)createCGPointMakeScale:(CGFloat)x andY:(CGFloat)y;
+(CGSize)createCGSizeMakeScale:(CGFloat)width andHeight:(CGFloat)height;

#pragma mark --创建数据模型
+(void)createModelFromDictionary:(NSDictionary *)dict className:(NSString *)className;

#pragma mark --创建Label
+(UILabel*)createLineLabWithFrame:(CGRect)frame;
+(UILabel*)createLabelWithFrame:(CGRect)frame Font:(int)font Text:(NSString*)text;
#pragma mark --创建View
+(UIView*)viewWithFrame:(CGRect)frame;
#pragma mark --创建imageView
+(UIImageView*)createImageViewWithFrame:(CGRect)frame ImageName:(NSString*)imageName;
#pragma mark --创建button
+(UIButton*)createButtonWithFrame:(CGRect)frame ImageName:(NSString*)imageName Target:(id)target Action:(SEL)action Title:(NSString*)title;
+(UIButton*)createRightButtonWithFrame:(CGRect)frame ImageName:(NSString*)imageName Target:(id)target Action:(SEL)action Title:(NSString*)title;//文字在左图片在右
#pragma mark --创建UITextField
+(UITextField*)createTextFieldWithFrame:(CGRect)frame placeholder:(NSString*)placeholder passWord:(BOOL)YESorNO leftImageView:(UIImageView*)imageView rightImageView:(UIImageView*)rightImageView Font:(float)font;

+(UITextField*)createTextFieldWithFrame:(CGRect)frame placeholder:(NSString*)placeholder KeyboardType:(UIKeyboardType)keyboardType Font:(float)font PlaceColor:(UIColor *)color;
+(UISearchBar*)createSearchBarWithFrame:(CGRect)frame placeholder:(NSString *)placeholder  backImagName:(NSString *)imageName;

//适配器的方法  扩展性方法
//现有方法，已经在工程里面存在，如果修改工程内所有方法，工作量巨大，就需要使用适配器的方法
+(UITextField*)createTextFieldWithFrame:(CGRect)frame placeholder:(NSString*)placeholder passWord:(BOOL)YESorNO leftImageView:(UIImageView*)imageView rightImageView:(UIImageView*)rightImageView Font:(float)font backgRoundImageName:(NSString*)imageName;
#pragma mark 创建UIScrollView
+(UIScrollView*)makeScrollViewWithFrame:(CGRect)frame andSize:(CGSize)size;
+(UIScrollView *)createUIScrollViewWithFrame:(CGRect)frame contentSize:(CGSize)size pagingEnabled:(BOOL)pagingEnabled showsHorizontalScrollIndicator:(BOOL)showsHorizontalScrollIndicator showsVerticalScrollIndicator:(BOOL)showsVerticalScrollIndicator delegate:(id)delegate;
#pragma mark 创建UIPageControl
+(UIPageControl*)makePageControlWithFram:(CGRect)frame;
#pragma mark 创建UISlider
+(UISlider*)makeSliderWithFrame:(CGRect)rect AndImage:(UIImage*)image;
#pragma mark 创建时间转换字符串
+(NSString *)stringFromDateWithHourAndMinute:(NSDate *)date;
#pragma mark --判断导航的高度64or44
+(float)isIOS7;

#pragma mark 内涵图需要的方法
+ (NSString *)stringDateWithTimeInterval:(NSString *)timeInterval;

+ (CGFloat)textHeightWithString:(NSString *)text width:(CGFloat)width fontSize:(NSInteger)fontSize;

+ (NSString *)addOneByIntegerString:(NSString *)integerString;
//#pragma mark --判断设备型号
//+(NSString *)platformString;
+(UIButton*)createButtonWithFrame:(CGRect)frame ImageName:(NSString*)imageName Title:(NSString*)title Font:(CGFloat)font TitleColor:(UIColor *)color BackgroundColor:(UIColor *)backgroundColor;
+(NSMutableAttributedString *)attTextWithTextStr:(NSString *)textStr FontSize:(CGFloat)fontSize ImageStr:(NSString *)imageStr IsQuesLab:(BOOL)isQuesLab; //文字/字体大小/文字前的图片/是不是问题
//html增加格式文字图片适应屏幕
+ (NSString *)loadWebHtmlStr:(NSString *)h5Str;

/**
 获取验证码
 
 @param firstLabel  提示lable
 @param codeBtn     获取验证码按钮
 @param timeLabel   时间label
 @param backLabel   提示lable
 */
+ (void)getAuthCodeFirstLabel:(UILabel *)firstLabel codeBtn:(UIButton *)codeBtn timeLabel:(UILabel *)timeLabel andbackLabel:(UILabel *)backLabel;

/**
 手机号码
 */
+ (BOOL)validateMobile:(NSString *)mobile;

/**
 校验邮箱
 */
+ (BOOL)validateEmail:(NSString *)email;

+ (NSString *)UIUtilsFomateJsonWithDictionary:(NSDictionary *)dic;
    
+ (NSString*)encodeString:(NSString*)unencodedString;

+ (void)checkOutPassWithArr:(NSArray *)arr success:(void(^)(int code))success failure:(void (^)(int code))failure;

+(void)sd_imageForGiforCommonWithImageView:(UIImageView *)imageView andUrl:(NSString *)urlStr;

@end
