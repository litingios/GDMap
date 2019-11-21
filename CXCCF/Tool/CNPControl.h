//
//  CNPControl.h
//  CNP_AIWIFI
//
//  Created by qiaowa on 16/11/22.
//  Copyright © 2016年 WJ. All rights reserved.
//

#import <Foundation/Foundation.h>

#pragma mark - label 宏定义区域
///基本label superView
#define get_LabelStyleOne(frame,superView,tag,text) [CNPControl addLabelWithFrame:frame SuperView:superView LabelTag:tag LabelText:text]
//font textcolor textalignment superView
#define get_labelStyleTwo(frame,font,color,alignment,superView,tag,text) [CNPControl addLabelWithFrame:frame LabelFont:font LabelTextColor:color LabelTextAlignment:alignment SuperView:superView LabelTag:tag LabelText:text]

/// fontSize textcolor textalignment superView
#define get_labelStyleThree(frame,fontSize,color,alignment,superView,tag,text) [CNPControl addLabelWithFrame:frame LabelFontSize:fontSize LabelTextColor:color LabelTextAlignment:alignment SuperView:superView LabelTag:tag LabelText:text]

//AttributedString  fontSize textcolor textalignment
#define get_labelAttributedStringStyleThree(frame,fontSize,color,alignment,superView,tag,attText) [CNPControl addLabelWithFrame:frame LabelAttributeText:attText LabelFontSize:fontSize LabelTextColor:color LabelTextAlignment:alignment SuperView:superView LabelTag:tag]
///设置换行模式 font textcolor textalignment superView
#define get_labelStyleFour(frame,lineBreakMode,font,color,alignment,superView,tag,text) [CNPControl addLabelWithFrame:frame LineBreakMode:lineBreakMode LabelFont:font LabelTextColor:color LabelTextAlignment:alignment SuperView:superView LabelTag:tag LabelText:text]

///设置换行模式 fontSize textcolor textalignment superView
#define get_labelStyleFive(frame,LineBreakMode,fontSize,color,alignment,superView,tag,text) [CNPControl addLabelWithFrame:frame LineBreakMode:lineBreakMode LabelFontSize:fontSize LabelTextColor:color LabelTextAlignment:alignment SuperView:superView LabelTag:tag LabelText:text]

///设置换行模式 font textcolor textalignment lineNum superView
#define get_labelStyleSix(frame,lineNum,font,color,alignment,superView,tag,text) [CNPControl addLabelWithFrame:frame LineNum:lineNum LabelFont:font LabelTextColor:color LabelTextAlignment:alignment SuperView:superView LabelTag:tag LabelText:text]

///设置换行模式 fontSize textcolor textalignment LineNum superView
#define get_labelStyleSeven(frame,lineNum,fontSize,color,alignment,superView,tag,text) [CNPControl addLabelWithFrame:frame LineNum:lineNum LabelFontSize:fontSize LabelTextColor:color LabelTextAlignment:alignment SuperView:superView LabelTag:tag LabelText:text]

/// fontsize textcolor textalignment bgcolor cornerRadius superView
#define get_labelStyleEight(frame,fontSize,color,alignment,superView,tag,bgColor,cornerRadius,text) [CNPControl addLabelWithFrame:frame LabelFontSize:fontSize LabelTextColor:color LabelTextAlignment:alignment SuperView:superView LabelTag:tag LabelText:text BackgroundColor:bgColor CornerRadius:cornerRadius]

#pragma mark - button 宏定义区域
///空白button
#define get_buttonCustomStyle(rect,tag,superView,target,action,controlevent) [CNPControl addbuttonWithRect:rect  buttonTag:tag SuperView:superView buttonTarget:target Action:action buttonEvents:controlevent]
///默认button点击事件是 UIControlEventTouchDown
#define get_buttonCustomStyle_EventDown(rect,tag,superView,target,action) [CNPControl addbuttonWithRect:rect  buttonTag:tag SuperView:superView buttonTarget:target Action:action]

///默认事件是点击按下 设置图片
#define get_buttonAllImage_EventDown(rect,tag,superView,target,action,normalPic,highlightPic,selectPic) [CNPControl addbuttonWithRect:rect  buttonTag:tag SuperView:superView buttonTarget:target Action:action NormalPicState:normalPic HighlightPicState:highlightPic selectPicState:selectPic]

///带文字button 带背景颜色的
#define get_buttonTextAndBgStyle_EventDown(rect,font,normalTextColor,highLightTextColor,selectTextColor,normalBgColor,selectBgColor,lightBgColor,tag,superView,target,action,text) [CNPControl addbuttonWithRect:rect LabelText:text TextFont:font NormalTextColor:normalTextColor HighLightTextColor:highLightTextColor SelectTextColor:selectTextColor  NormalBgColor:normalBgColor HighLightBgColor:lightBgColor SelectBgColor:selectBgColor  ButtonTag:tag SuperView:superView buttonTarget:target Action:action]

///带文字button 带背景颜色的 带边界颜色都button
#define get_buttonBorderStyle_EventInside(rect,layerBorderColor,font,normalTextColor,highLightTextColor,selectTextColor,normalBgColor,lightBgColor,selectBgColor,tag,superView,target,action,text) [CNPControl addbuttonEventInsideWithRect:rect LayerBorderColor:layerBorderColor LabelText:text  TextFont:font NormalTextColor:normalTextColor HighLightTextColor:highLightTextColor SelectTextColor:selectTextColor  NormalBgColor:normalBgColor HighLightBgColor:lightBgColor SelectBgColor:selectBgColor  buttonTag:tag SuperView:superView buttonTarget:target Action:action]

///带文字button 带背景颜色的 带边界颜色都button
#define get_buttonBorderStyle_EventDown(rect,layerBorderColor,font,normalTextColor,highLightTextColor,selectTextColor,normalBgColor,lightBgColor,selectBgColor,tag,superView,target,action,text) [CNPControl addbuttonWithRect:rect LayerBorderColor:layerBorderColor LabelText:text  TextFont:font NormalTextColor:normalTextColor HighLightTextColor:highLightTextColor SelectTextColor:selectTextColor  NormalBgColor:normalBgColor HighLightBgColor:lightBgColor SelectBgColor:selectBgColor  buttonTag:tag SuperView:superView buttonTarget:target Action:action]

///带文字button 带背景颜色的 带边界颜色都button CornerRadius EventInside
#define get_buttonCornerRadiusStyle_EventInside(rect,cornerRadius,layerBorderColor,font,normalTextColor,highLightTextColor,selectTextColor,normalBgColor,lightBgColor,selectBgColor,tag,superView,target,action,text)   [CNPControl  addbuttonEventInsideWithRect:rect CornerRadius:cornerRadius LayerBorderColor:layerBorderColor LabelText:text  TextFont:(UIFont *)font NormalTextColor:normalTextColor HighLightTextColor:highLightTextColor SelectTextColor:selectTextColor  NormalBgColor:normalBgColor HighLightBgColor:lightBgColor SelectBgColor:selectBgColor  buttonTag:tag SuperView:superView buttonTarget:target Action:action]
///带文字button 带背景颜色的 带边界颜色都button CornerRadius
#define get_buttonCornerRadiusStyle_EventDown(rect,cornerRadius,layerBorderColor,font,normalTextColor,highLightTextColor,selectTextColor,normalBgColor,lightBgColor,selectBgColor,tag,superView,target,action,text)   [CNPControl  addbuttonWithRect:rect CornerRadius:cornerRadius LayerBorderColor:layerBorderColor LabelText:text  TextFont:(UIFont *)font NormalTextColor:normalTextColor HighLightTextColor:highLightTextColor SelectTextColor:selectTextColor  NormalBgColor:normalBgColor HighLightBgColor:lightBgColor SelectBgColor:selectBgColor  buttonTag:tag SuperView:superView buttonTarget:target Action:action]

#pragma mark - UIimageView 宏定义区域
///添加网络图片
#define get_ImageViewUrlStyle(tag,imageRect,superView,imageUrlStr,placeLocalStr) [CNPControl addUrlImageViewForUrl:imageUrlStr placeImageStr:placeLocalStr ImageViewTag:tag rect:imageRect SuperView:superView]
//添加本地图片
#define get_ImageViewLocalStyle(imageNameStr,tag,viewRect,superView) [CNPControl addImageView:imageNameStr ImageViewTag:tag rect:viewRect SuperView:superView]
#pragma mark - uiview 宏定义区域
///没有父类View
#define get_ViewNoSuperViewStyleBase(rect,tag,color) [CNPControl addViewRect:rect  ViewTag:tag ViewBgColor:color]

///基本uiview superView
#define get_LineStyleBase(rect,superView,tag,color)  [CNPControl addLineViewRect:rect SuperView:superView LineTag:tag lineColor:color]

/// 线宽是1  宽度为屏幕宽度 superView
#define get_LineStyleLineColor(lineLocation,superView,lineColor,tag) [CNPControl addLineView:lineLocation SuperView:superView LineColor:lineColor  LineTag:tag]

///默认线颜色是 #a90bc4 superView rect
#define get_LineStyle_090bc4_Rect(rect,superView,tag) [CNPControl addLineViewRect:rect SuperView:superView  LineTag:tag]

///默认线是颜色 #a90bc4 线宽是1  左右空缺相同 superView
#define get_LineStyle_090bc4_Point(point,superView,tag) [CNPControl addLineViewOriginPoint:point SuperView:superView  LineTag:tag]

///默认线是颜色 #a90bc4 线宽是1  宽度为屏幕宽度 superView
#define get_LineStyle_090bc4_PointX(lineY,superView,tag) [CNPControl addLineView:lineY SuperView:superView LineTag:tag]

//view设置背景 superView
#define get_ViewStyle_bgColor(rect,superView,tag,color) [CNPControl addViewRect:rect SuperView:superView  LineTag:tag lineColor:color]

#define get_callPhone(phoneNum,object) [CNPControl callPhone:phoneNum delegate:object]

@interface CNPControl : NSObject
#pragma mark- label 区域
///基本label superView
+(UILabel *)addLabelWithFrame:(CGRect)frame SuperView:(UIView *)superView LabelTag:(NSInteger)tag LabelText:(NSString *)text;

//font textcolor textalignment superView
+(UILabel *)addLabelWithFrame:(CGRect)frame LabelFont:(UIFont*)font LabelTextColor:(UIColor *)color LabelTextAlignment:(NSTextAlignment)alignment SuperView:(UIView *)superView LabelTag:(NSInteger)tag LabelText:(NSString *)text;

/// fontSize textcolor textalignment superView
+(UILabel *)addLabelWithFrame:(CGRect)frame LabelFontSize:(float)fontSize LabelTextColor:(UIColor *)color LabelTextAlignment:(NSTextAlignment)alignment SuperView:(UIView *)superView LabelTag:(NSInteger)tag LabelText:(NSString *)text;

///设置换行模式 font textcolor textalignment superView
+(UILabel *)addLabelWithFrame:(CGRect)frame LineBreakMode:(NSLineBreakMode)lineBreakMode LabelFont:(UIFont*)font LabelTextColor:(UIColor *)color LabelTextAlignment:(NSTextAlignment)alignment SuperView:(UIView *)superView LabelTag:(NSInteger)tag LabelText:(NSString *)text;

///设置换行模式 fontSize textcolor textalignment superView
+(UILabel *)addLabelWithFrame:(CGRect)frame LineBreakMode:(NSLineBreakMode)lineBreakMode LabelFontSize:(float)fontSize LabelTextColor:(UIColor *)color LabelTextAlignment:(NSTextAlignment)alignment SuperView:(UIView *)superView LabelTag:(NSInteger)tag LabelText:(NSString *)text;

///设置换行模式 font textcolor textalignment lineNum superView
+(UILabel *)addLabelWithFrame:(CGRect)frame LineNum:(NSInteger)lineNum LabelFont:(UIFont*)font LabelTextColor:(UIColor *)color LabelTextAlignment:(NSTextAlignment)alignment SuperView:(UIView *)superView LabelTag:(NSInteger)tag LabelText:(NSString *)text;

///设置换行模式 fontSize textcolor textalignment LineNum superView
+(UILabel *)addLabelWithFrame:(CGRect)frame LineNum:(NSInteger)lineNum LabelFontSize:(float)fontSize LabelTextColor:(UIColor *)color LabelTextAlignment:(NSTextAlignment)alignment SuperView:(UIView *)superView LabelTag:(NSInteger)tag LabelText:(NSString *)text;

//AttributedString  fontSize textcolor textalignment
+(UILabel *)addLabelWithFrame:(CGRect)frame LabelAttributeText:(NSAttributedString *)attText LabelFontSize:(float)fontSize LabelTextColor:(UIColor *)color LabelTextAlignment:(NSTextAlignment)alignment SuperView:(UIView *)superView LabelTag:(NSInteger)tag;

/// fontsize textcolor textalignment bgcolor cornerRadius superView
+(UILabel *)addLabelWithFrame:(CGRect)frame LabelFontSize:(float)fontSize LabelTextColor:(UIColor *)color LabelTextAlignment:(NSTextAlignment)alignment SuperView:(UIView *)superView LabelTag:(NSInteger)tag LabelText:(NSString *)text BackgroundColor:(UIColor *)bgColor CornerRadius:(float)cornerRadius;
#pragma mark - button 区域
///空白button
+ (UIButton *)addbuttonWithRect:(CGRect)rect  buttonTag:(NSInteger)tag SuperView:(UIView *)superView buttonTarget:(id)target Action:(SEL)action buttonEvents:(UIControlEvents)controlevent;
///默认button点击事件是 UIControlEventTouchDown
+(UIButton *)addbuttonWithRect:(CGRect)rect  buttonTag:(NSInteger)tag SuperView:(UIView *)superView buttonTarget:(id)target Action:(SEL)action;

///默认事件是点击按下 设置图片
+(UIButton *)addbuttonWithRect:(CGRect)rect  buttonTag:(NSInteger)tag SuperView:(UIView *)superView buttonTarget:(id)target Action:(SEL)action NormalPicState:(NSString *)normalPic HighlightPicState:(NSString *)highlightPic selectPicState:(NSString *)selectPic;

///带文字button 带背景颜色的
+(UIButton *)addbuttonWithRect:(CGRect)rect LabelText:(NSString *)text TextFont:(UIFont *)font NormalTextColor:(UIColor *)normalTextColor HighLightTextColor:(UIColor *)highLightTextColor SelectTextColor:(UIColor *)selectTextColor  NormalBgColor:(UIColor *)normalBgColor HighLightBgColor:(UIColor *)lightBgColor SelectBgColor:(UIColor *)selectBgColor  ButtonTag:(NSInteger)tag SuperView:(UIView *)superView buttonTarget:(id)target Action:(SEL)action;
///带文字button 带背景颜色的 带边界颜色都button event INside
+(UIButton *)addbuttonEventInsideWithRect:(CGRect)rect LayerBorderColor:(UIColor *)layerBorderColor LabelText:(NSString *)text  TextFont:(UIFont *)font NormalTextColor:(UIColor *)normalTextColor HighLightTextColor:(UIColor *)highLightTextColor SelectTextColor:(UIColor *)selectTextColor  NormalBgColor:(UIColor *)normalBgColor HighLightBgColor:(UIColor *)lightBgColor SelectBgColor:(UIColor *)selectBgColor  buttonTag:(NSInteger)tag SuperView:(UIView *)superView buttonTarget:(id)target Action:(SEL)action;
///带文字button 带背景颜色的 带边界颜色都button
+(UIButton *)addbuttonWithRect:(CGRect)rect LayerBorderColor:(UIColor *)layerBorderColor LabelText:(NSString *)text  TextFont:(UIFont *)font NormalTextColor:(UIColor *)normalTextColor HighLightTextColor:(UIColor *)highLightTextColor SelectTextColor:(UIColor *)selectTextColor  NormalBgColor:(UIColor *)normalBgColor HighLightBgColor:(UIColor *)lightBgColor SelectBgColor:(UIColor *)selectBgColor  buttonTag:(NSInteger)tag SuperView:(UIView *)superView buttonTarget:(id)target Action:(SEL)action;

///带文字button 带背景颜色的 带边界颜色都button CornerRadius event inside
+(UIButton *)addbuttonEventInsideWithRect:(CGRect)rect CornerRadius:(float)cornerRadius LayerBorderColor:(UIColor *)layerBorderColor LabelText:(NSString *)text  TextFont:(UIFont *)font NormalTextColor:(UIColor *)normalTextColor HighLightTextColor:(UIColor *)highLightTextColor SelectTextColor:(UIColor *)selectTextColor  NormalBgColor:(UIColor *)normalBgColor HighLightBgColor:(UIColor *)lightBgColor SelectBgColor:(UIColor *)selectBgColor  buttonTag:(NSInteger)tag SuperView:(UIView *)superView buttonTarget:(id)target Action:(SEL)action;
///带文字button 带背景颜色的 带边界颜色都button CornerRadius
+(UIButton *)addbuttonWithRect:(CGRect)rect CornerRadius:(float)cornerRadius LayerBorderColor:(UIColor *)layerBorderColor LabelText:(NSString *)text  TextFont:(UIFont *)font NormalTextColor:(UIColor *)normalTextColor HighLightTextColor:(UIColor *)highLightTextColor SelectTextColor:(UIColor *)selectTextColor  NormalBgColor:(UIColor *)normalBgColor HighLightBgColor:(UIColor *)lightBgColor SelectBgColor:(UIColor *)selectBgColor  buttonTag:(NSInteger)tag SuperView:(UIView *)superView buttonTarget:(id)target Action:(SEL)action;
#pragma mark - imageView 区域
//添加本地图片
+ (UIImageView *)addImageView:(NSString * )imageName ImageViewTag:(NSInteger)tag rect:(CGRect)imageRect SuperView:(UIView *)superView;
#pragma mark - UIView 区域
///没有父类View
+(UIView *)addViewRect:(CGRect)rect  ViewTag:(NSInteger)tag ViewBgColor:(UIColor *)color;

///基本uiview superView
+(UIView *)addLineViewRect:(CGRect)rect SuperView:(UIView *)superView  LineTag:(NSInteger)tag lineColor:(UIColor *)color;

///默认线颜色是 #a90bc4 superView
+(UIView *)addLineViewRect:(CGRect)rect SuperView:(UIView *)superView  LineTag:(NSInteger)tag;

///默认线是颜色 #a90bc4 线宽是1  左右空缺相同 superView
+(UIView *)addLineViewOriginPoint:(CGPoint)point SuperView:(UIView *)superView  LineTag:(NSInteger)tag;

///默认线是颜色 #a90bc4 线宽是1  宽度为屏幕宽度 superView
+(UIView *)addLineView:(CGFloat)line SuperView:(UIView *)superView  LineTag:(NSInteger)tag;

/// 线宽是1  宽度为屏幕宽度 superView
+(UIView *)addLineView:(CGFloat)lineLocation SuperView:(UIView *)superView LineColor:(UIColor *)lineColor  LineTag:(NSInteger)tag;

//view设置背景 superView
+(UIView *)addViewRect:(CGRect)rect SuperView:(UIView *)superView  LineTag:(NSInteger)tag lineColor:(UIColor *)color;


///打电话
+(void)callPhone:(NSString *)phoneNum delegate:(NSObject *)object;

//获取背景纯色图片
+(UIImage *)getbuttonImage:(CGRect )rect color:(UIColor *)color;
+(UIImage *)getbuttonImage:(CGRect)rect color:(UIColor *)color Radius:(int)radius ShadowOffset:(int)offset shadowColor:(UIColor *)shadowColor;



+(NSMutableAttributedString *)iterationTextFontWithText:(NSString *)text andFontSize:(int)fontSize andSubStringAbandonNum:(int)num andWidth:(float)width OtherWidth:(float)otherWidth;

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
 时间转换

 @param  time 时间戳
 @return      标准时间
 */
+ (NSString *)conversionTime:(NSString *)time;


@end

