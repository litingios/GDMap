//
//  CNPControl.m
//  CNP_AIWIFI
//
//  Created by qiaowa on 16/11/22.
//  Copyright © 2016年 WJ. All rights reserved.
//
#import "CNPControl.h"
#import <Foundation/Foundation.h>
/// 屏幕宽度
#define N_Screen_Width [UIScreen mainScreen].bounds.size.width
///屏幕高度
#define N_Screen_Height  [UIScreen mainScreen].bounds.size.height

@implementation CNPControl
#pragma mark- label 区域
//基本label
+(UILabel *)addLabelWithFrame:(CGRect)frame SuperView:(UIView *)superView LabelTag:(NSInteger)tag LabelText:(NSString *)text
{
    if (![superView viewWithTag:tag]) {
        UILabel * label = [[UILabel alloc] initWithFrame:frame];
        [label setBackgroundColor:[UIColor clearColor]];
        [label setText:text];
        [label setTag:tag];
        [superView addSubview:label];
    }else{
        UILabel * label = (UILabel *)[superView viewWithTag:tag];
        [label setFrame:frame];
        [label setText:text];
    }
    return (UILabel *)[superView viewWithTag:tag];
}

//font textcolor textalignment
+(UILabel *)addLabelWithFrame:(CGRect)frame LabelFont:(UIFont*)font LabelTextColor:(UIColor *)color LabelTextAlignment:(NSTextAlignment)alignment SuperView:(UIView *)superView LabelTag:(NSInteger)tag LabelText:(NSString *)text
{
    UILabel * label =[self addLabelWithFrame:frame SuperView:superView LabelTag:tag LabelText:text];
    [label setFont:font];
    [label setTextColor:color];
    [label setTextAlignment:alignment];
    return label;
    
    
}

// fontSize textcolor textalignment
+(UILabel *)addLabelWithFrame:(CGRect)frame LabelFontSize:(float)fontSize LabelTextColor:(UIColor *)color LabelTextAlignment:(NSTextAlignment)alignment SuperView:(UIView *)superView LabelTag:(NSInteger)tag LabelText:(NSString *)text
{
    return [self addLabelWithFrame:frame LabelFont:[UIFont systemFontOfSize:fontSize] LabelTextColor:color LabelTextAlignment:alignment SuperView:superView LabelTag:tag LabelText:text];
}
//AttributedString  fontSize textcolor textalignment
+(UILabel *)addLabelWithFrame:(CGRect)frame LabelAttributeText:(NSAttributedString *)attText LabelFontSize:(float)fontSize LabelTextColor:(UIColor *)color LabelTextAlignment:(NSTextAlignment)alignment SuperView:(UIView *)superView LabelTag:(NSInteger)tag {
    
    UILabel * label= [self addLabelWithFrame:frame LabelFont:[UIFont systemFontOfSize:fontSize] LabelTextColor:color LabelTextAlignment:alignment SuperView:superView LabelTag:tag LabelText:nil];
    label.attributedText = attText;
    return label;
}

// fontsize textcolor textalignment bgcolor cornerRadius
+(UILabel *)addLabelWithFrame:(CGRect)frame LabelFontSize:(float)fontSize LabelTextColor:(UIColor *)color LabelTextAlignment:(NSTextAlignment)alignment SuperView:(UIView *)superView LabelTag:(NSInteger)tag LabelText:(NSString *)text BackgroundColor:(UIColor *)bgColor CornerRadius:(float)cornerRadius
{
    UILabel * label =[self addLabelWithFrame:frame LabelFontSize:fontSize  LabelTextColor:color LabelTextAlignment:alignment SuperView:superView LabelTag:tag LabelText:text];
    label.backgroundColor = bgColor;
    label.layer.cornerRadius = cornerRadius;
    label.layer.masksToBounds = YES;
    return label;
    
}
//设置换行模式 font textcolor textalignment
+(UILabel *)addLabelWithFrame:(CGRect)frame LineBreakMode:(NSLineBreakMode)lineBreakMode LabelFont:(UIFont*)font LabelTextColor:(UIColor *)color LabelTextAlignment:(NSTextAlignment)alignment SuperView:(UIView *)superView LabelTag:(NSInteger)tag LabelText:(NSString *)text
{
    UILabel *label = [self addLabelWithFrame:frame LabelFont:font LabelTextColor:color LabelTextAlignment:alignment SuperView:superView LabelTag:tag LabelText:text];
    [label setNumberOfLines:0];
    [label setLineBreakMode:lineBreakMode];
    return label;
}

//设置换行模式 fontSize textcolor textalignment
+(UILabel *)addLabelWithFrame:(CGRect)frame LineBreakMode:(NSLineBreakMode)lineBreakMode LabelFontSize:(float)fontSize LabelTextColor:(UIColor *)color LabelTextAlignment:(NSTextAlignment)alignment SuperView:(UIView *)superView LabelTag:(NSInteger)tag LabelText:(NSString *)text
{
    UILabel * label =[self addLabelWithFrame:frame LabelFontSize:fontSize LabelTextColor:color LabelTextAlignment:alignment SuperView:superView LabelTag:tag LabelText:text   ];
    [label setLineBreakMode:lineBreakMode];
    return label;
}

///设置换行模式 font textcolor textalignment lineNum
+(UILabel *)addLabelWithFrame:(CGRect)frame LineNum:(NSInteger)lineNum LabelFont:(UIFont*)font LabelTextColor:(UIColor *)color LabelTextAlignment:(NSTextAlignment)alignment SuperView:(UIView *)superView LabelTag:(NSInteger)tag LabelText:(NSString *)text
{
    UILabel *label = [self addLabelWithFrame:frame LabelFont:font LabelTextColor:color LabelTextAlignment:alignment SuperView:superView LabelTag:tag LabelText:text];
    [label setNumberOfLines:lineNum];
    return label;
}

///设置换行模式 fontSize textcolor textalignment LineNum
+(UILabel *)addLabelWithFrame:(CGRect)frame LineNum:(NSInteger)lineNum LabelFontSize:(float)fontSize LabelTextColor:(UIColor *)color LabelTextAlignment:(NSTextAlignment)alignment SuperView:(UIView *)superView LabelTag:(NSInteger)tag LabelText:(NSString *)text
{
    UILabel * label =[self addLabelWithFrame:frame LabelFontSize:fontSize LabelTextColor:color LabelTextAlignment:alignment SuperView:superView LabelTag:tag LabelText:text   ];
    [label setNumberOfLines:lineNum];
    return label;
}

#pragma mark - button 区域
//空白button
+ (UIButton *)addbuttonWithRect:(CGRect)rect  buttonTag:(NSInteger)tag SuperView:(UIView *)superView buttonTarget:(id)target Action:(SEL)action buttonEvents:(UIControlEvents)controlevent
{
    if (![superView viewWithTag:tag]) {
        UIButton *button = [[UIButton alloc] initWithFrame:rect];
        [button addTarget:target action:action forControlEvents:controlevent];
        [button setTag:tag];
        [button setExclusiveTouch:YES];
        [superView addSubview:button];
    }else
    {
        UIButton * button = (UIButton *)[superView viewWithTag:tag];
        [button setFrame:rect];
        [button setExclusiveTouch:YES];
        [button addTarget:target action:action forControlEvents:controlevent];
        [button setTag:tag];
    }
    return (UIButton *)[superView viewWithTag:tag];
}

//默认button点击事件是 UIControlEventTouchDown
+(UIButton *)addbuttonWithRect:(CGRect)rect  buttonTag:(NSInteger)tag SuperView:(UIView *)superView buttonTarget:(id)target Action:(SEL)action
{
    return  [self addbuttonWithRect:rect buttonTag:tag SuperView:superView buttonTarget:target Action:action buttonEvents:UIControlEventTouchDown];
}
///默认事件是点击按下 设置图片
+(UIButton *)addbuttonWithRect:(CGRect)rect  buttonTag:(NSInteger)tag SuperView:(UIView *)superView buttonTarget:(id)target Action:(SEL)action NormalPicState:(NSString *)normalPic HighlightPicState:(NSString *)highlightPic selectPicState:(NSString *)selectPic
{
    UIButton * button=[self addbuttonWithRect:rect buttonTag:tag SuperView:superView buttonTarget:target Action:action];
    [button setImage:[UIImage imageNamed:normalPic] forState:UIControlStateNormal];
    if (selectPic) {
        [button setImage:[UIImage imageNamed:selectPic] forState:UIControlStateSelected];
    }
    [button setImage:[UIImage imageNamed:highlightPic] forState:UIControlStateHighlighted];
    return  button;
}

///带文字button 这个暂时线不放开用
+(UIButton *)addbuttonWithRect:(CGRect)rect LabelText:(NSString *)text TextFont:(UIFont *)font NormalTextColor:(UIColor *)normalTextColor HighLightTextColor:(UIColor *)highLightTextColor SelectTextColor:(UIColor *)selectTextColor ButtonTag:(NSInteger)tag SuperView:(UIView *)superView buttonTarget:(id)target Action:(SEL)action
{
    UIButton * button = [self addbuttonWithRect:rect buttonTag:tag SuperView:superView buttonTarget:target Action:action];
    
    [button.titleLabel setFont:font];
    [button setTitle:text forState:UIControlStateNormal];
    [button setTitle:text forState:UIControlStateHighlighted];
    [button setTitleColor:normalTextColor forState:UIControlStateNormal];
    if (highLightTextColor) {
        [button setTitleColor:highLightTextColor forState:UIControlStateHighlighted];
    }
    if (selectTextColor) {
        [button setTitleColor:selectTextColor forState:UIControlStateSelected];
    }
    return button;
}

///带文字button 带背景颜色的
+(UIButton *)addbuttonWithRect:(CGRect)rect LabelText:(NSString *)text TextFont:(UIFont *)font NormalTextColor:(UIColor *)normalTextColor HighLightTextColor:(UIColor *)highLightTextColor SelectTextColor:(UIColor *)selectTextColor  NormalBgColor:(UIColor *)normalBgColor HighLightBgColor:(UIColor *)lightBgColor SelectBgColor:(UIColor *)selectBgColor  ButtonTag:(NSInteger)tag SuperView:(UIView *)superView buttonTarget:(id)target Action:(SEL)action
{
    UIButton * button =[self addbuttonWithRect:rect LabelText:text TextFont:font NormalTextColor:normalTextColor HighLightTextColor:highLightTextColor SelectTextColor:selectTextColor ButtonTag:tag SuperView:superView buttonTarget:target Action:action];
    
    [button setBackgroundImage:[self getbuttonImage:CGRectMake(0, 0, rect.size.width, rect.size.height) color:normalBgColor] forState:UIControlStateNormal];
    if (lightBgColor) {
        [button setBackgroundImage:[self getbuttonImage:CGRectMake(0, 0, rect.size.width, rect.size.height) color:lightBgColor] forState:UIControlStateHighlighted];
    }
    if (selectBgColor) {
        [button setBackgroundImage:[self getbuttonImage:CGRectMake(0, 0, rect.size.width, rect.size.height) color:selectBgColor] forState:UIControlStateSelected];
    }
    return button;
}

///带文字button 带背景颜色的 带边界颜色都button event INside
+(UIButton *)addbuttonEventInsideWithRect:(CGRect)rect LayerBorderColor:(UIColor *)layerBorderColor LabelText:(NSString *)text  TextFont:(UIFont *)font NormalTextColor:(UIColor *)normalTextColor HighLightTextColor:(UIColor *)highLightTextColor SelectTextColor:(UIColor *)selectTextColor  NormalBgColor:(UIColor *)normalBgColor HighLightBgColor:(UIColor *)lightBgColor SelectBgColor:(UIColor *)selectBgColor  buttonTag:(NSInteger)tag SuperView:(UIView *)superView buttonTarget:(id)target Action:(SEL)action
{
    UIButton *button= [self addbuttonWithRect:rect LayerBorderColor:layerBorderColor LabelText:text TextFont:font NormalTextColor:normalTextColor HighLightTextColor:highLightTextColor SelectTextColor:selectTextColor NormalBgColor:normalBgColor HighLightBgColor:lightBgColor SelectBgColor:selectBgColor buttonTag:tag SuperView:superView buttonTarget:target Action:action];
    [button removeTarget:target action:action forControlEvents:UIControlEventTouchDown];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return button;
}

///带文字button 带背景颜色的 带边界颜色都button
+(UIButton *)addbuttonWithRect:(CGRect)rect LayerBorderColor:(UIColor *)layerBorderColor LabelText:(NSString *)text  TextFont:(UIFont *)font NormalTextColor:(UIColor *)normalTextColor HighLightTextColor:(UIColor *)highLightTextColor SelectTextColor:(UIColor *)selectTextColor  NormalBgColor:(UIColor *)normalBgColor HighLightBgColor:(UIColor *)lightBgColor SelectBgColor:(UIColor *)selectBgColor  buttonTag:(NSInteger)tag SuperView:(UIView *)superView buttonTarget:(id)target Action:(SEL)action
{
    UIButton * button = [self addbuttonWithRect:rect LabelText:text TextFont:font NormalTextColor:normalTextColor HighLightTextColor:highLightTextColor SelectTextColor:selectTextColor NormalBgColor:normalBgColor HighLightBgColor:lightBgColor SelectBgColor:selectBgColor ButtonTag:tag SuperView:superView buttonTarget:target Action:action];
    
    button.layer.borderWidth = 1;
    button.layer.borderColor = layerBorderColor.CGColor;
    return button;
}

///带文字button 带背景颜色的 带边界颜色都button CornerRadius event inside
+(UIButton *)addbuttonEventInsideWithRect:(CGRect)rect CornerRadius:(float)cornerRadius LayerBorderColor:(UIColor *)layerBorderColor LabelText:(NSString *)text  TextFont:(UIFont *)font NormalTextColor:(UIColor *)normalTextColor HighLightTextColor:(UIColor *)highLightTextColor SelectTextColor:(UIColor *)selectTextColor  NormalBgColor:(UIColor *)normalBgColor HighLightBgColor:(UIColor *)lightBgColor SelectBgColor:(UIColor *)selectBgColor  buttonTag:(NSInteger)tag SuperView:(UIView *)superView buttonTarget:(id)target Action:(SEL)action
{
    UIButton * button= [self addbuttonWithRect:rect CornerRadius:cornerRadius LayerBorderColor:layerBorderColor LabelText:text  TextFont:font NormalTextColor:normalTextColor HighLightTextColor:highLightTextColor SelectTextColor:selectTextColor  NormalBgColor:normalBgColor HighLightBgColor:lightBgColor SelectBgColor:selectBgColor  buttonTag:tag SuperView:superView buttonTarget:target Action:action];
    [button removeTarget:target action:action forControlEvents:UIControlEventTouchDown];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return button;
}


///带文字button 带背景颜色的 带边界颜色都button CornerRadius
+(UIButton *)addbuttonWithRect:(CGRect)rect CornerRadius:(float)cornerRadius LayerBorderColor:(UIColor *)layerBorderColor LabelText:(NSString *)text  TextFont:(UIFont *)font NormalTextColor:(UIColor *)normalTextColor HighLightTextColor:(UIColor *)highLightTextColor SelectTextColor:(UIColor *)selectTextColor  NormalBgColor:(UIColor *)normalBgColor HighLightBgColor:(UIColor *)lightBgColor SelectBgColor:(UIColor *)selectBgColor  buttonTag:(NSInteger)tag SuperView:(UIView *)superView buttonTarget:(id)target Action:(SEL)action
{
    UIButton * button =[self addbuttonWithRect:rect LayerBorderColor:layerBorderColor LabelText:text TextFont:font NormalTextColor:normalTextColor HighLightTextColor:highLightTextColor SelectTextColor:selectTextColor NormalBgColor:normalBgColor HighLightBgColor:lightBgColor SelectBgColor:selectBgColor buttonTag:tag SuperView:superView buttonTarget:target Action:action];
    if (cornerRadius < 2) {
        cornerRadius = 2;
    }
    button.layer.cornerRadius = cornerRadius;
    button.layer.masksToBounds = YES;
    return button;
}
#pragma mark - imageView 区域


//添加本地图片
+ (UIImageView *)addImageView:(NSString * )imageName ImageViewTag:(NSInteger)tag rect:(CGRect)imageRect SuperView:(UIView *)superView
{
    if (![superView viewWithTag:tag]) {
        UIImageView * imageView = [[UIImageView alloc]initWithFrame:imageRect];
        [imageView setImage:[UIImage imageNamed:imageName]];
        
        [imageView setTag:tag];
        [superView addSubview:imageView];
    }else {
        UIImageView * imageView = (UIImageView *)[superView viewWithTag:tag];
        [imageView setFrame:imageRect];
        [imageView setImage:[UIImage imageNamed:imageName]];
    }
    return (UIImageView *)[superView viewWithTag:tag];
}
#pragma mark - UIView 区域
///没有父类View
+(UIView *)addViewRect:(CGRect)rect  ViewTag:(NSInteger)tag ViewBgColor:(UIColor *)color
{
    UIView *   lineView =[[UIView alloc] initWithFrame:rect];
    [lineView setBackgroundColor:color];
    [lineView setTag:tag];
    return lineView;
}
///基本uiview superView
+(UIView *)addLineViewRect:(CGRect)rect SuperView:(UIView *)superView  LineTag:(NSInteger)tag lineColor:(UIColor *)color
{
    if (![superView viewWithTag:tag]) {
        UIView *   lineView =[[UIView alloc] initWithFrame:rect];
        [lineView setBackgroundColor:color];
        [lineView setTag:tag];
        [superView addSubview:lineView];
    }else{
        UIView * lineView = (UIView *)[superView viewWithTag:tag];
        [lineView setFrame:rect];
    }
    return [superView viewWithTag:tag];
}

//view设置背景
+(UIView *)addViewRect:(CGRect)rect SuperView:(UIView *)superView  LineTag:(NSInteger)tag lineColor:(UIColor *)color
{
    return [self addLineViewRect:rect SuperView:superView LineTag:tag lineColor:color];
}

+(UIView *)addLineViewRect:(CGRect)rect SuperView:(UIView *)superView  LineTag:(NSInteger)tag
{
    return  [self addLineViewRect:rect SuperView:superView LineTag:tag lineColor:[UIColor redColor]];
}

//默认线是颜色 #a90bc4 线宽是0.5 左右空缺相同
+(UIView *)addLineViewOriginPoint:(CGPoint)point SuperView:(UIView *)superView  LineTag:(NSInteger)tag
{
    return  [self addLineViewRect:CGRectMake(point.x, point.y, N_Screen_Width-point.x, 0.5) SuperView:superView LineTag:tag];
}

//默认线是颜色 #a90bc4 线宽是1  宽度为屏幕宽度
+(UIView *)addLineView:(CGFloat)line SuperView:(UIView *)superView  LineTag:(NSInteger)tag
{
    return [self addLineViewOriginPoint:CGPointMake(0, line) SuperView:superView LineTag:tag];
}

/// 线宽是1  宽度为屏幕宽度 superView
+(UIView *)addLineView:(CGFloat)lineLocation SuperView:(UIView *)superView LineColor:(UIColor *)lineColor  LineTag:(NSInteger)tag{
    return [self addLineViewRect:CGRectMake(0, lineLocation, N_Screen_Width, 0.5) SuperView:superView LineTag:tag lineColor:lineColor];
}

#pragma mark - 其他
//获取背景纯色图片
+(UIImage *)getbuttonImage:(CGRect )rect color:(UIColor *)color
{
    UIGraphicsBeginImageContextWithOptions(rect.size,NO,0);
    UIBezierPath* p =[UIBezierPath bezierPathWithRect:CGRectMake(0,0,rect.size.width,rect.size.height)];
    [color setFill];
    [p fill];
    UIImage*im=UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return im;
}

+(UIImage *)getbuttonImage:(CGRect)rect color:(UIColor *)color Radius:(int)radius ShadowOffset:(int)offset shadowColor:(UIColor *)shadowColor
{
    
    UIGraphicsBeginImageContextWithOptions(rect.size,NO,0);
    UIBezierPath* p =[UIBezierPath bezierPath];
    [p moveToPoint:CGPointMake(radius, 0)];
    [p  addLineToPoint:CGPointMake(radius+rect.size.width-2*radius, 0)];
    [p addArcWithCenter:CGPointMake(radius+rect.size.width-2*radius, radius) radius:radius startAngle:-M_PI_2 endAngle:0 clockwise:YES];
    [p addLineToPoint:CGPointMake(radius*2+rect.size.width-2*radius, radius+rect.size.height-2*radius-offset)];
    [p addArcWithCenter:CGPointMake(radius+rect.size.width-2*radius, radius+rect.size.height-2*radius-offset) radius:radius startAngle:0 endAngle:M_PI_2 clockwise:YES];
    [p addLineToPoint:CGPointMake(radius, radius*2+rect.size.height-2*radius-offset)];
    [p addArcWithCenter:CGPointMake(radius, radius+rect.size.height-2*radius-offset) radius:radius startAngle:M_PI_2 endAngle:M_PI clockwise:YES];
    [p addLineToPoint:CGPointMake(0, radius)];
    [p addArcWithCenter:CGPointMake(radius, radius) radius:radius startAngle:M_PI endAngle:M_PI_2*3 clockwise:YES];
    [color setFill];
    [p fill];
    
    p =[UIBezierPath bezierPath];
    [p moveToPoint:CGPointMake(0, rect.size.height-radius-offset)];
    [p addLineToPoint:CGPointMake(0, rect.size.height-radius)];
    [p addArcWithCenter:CGPointMake(radius, radius+rect.size.height-2*radius) radius:radius startAngle:M_PI endAngle:M_PI_2 clockwise:NO];
    [p addLineToPoint:CGPointMake(rect.size.width-radius, rect.size.height)];
    [p addArcWithCenter:CGPointMake(rect.size.width-radius, radius+rect.size.height-2*radius) radius:radius startAngle:M_PI_2 endAngle:0 clockwise:NO];
    [p addLineToPoint:CGPointMake(rect.size.width, rect.size.height-radius-offset)];
    [p addArcWithCenter:CGPointMake(radius+rect.size.width-2*radius, radius+rect.size.height-2*radius-offset) radius:radius startAngle:0 endAngle:M_PI_2 clockwise:YES];
    [p addLineToPoint:CGPointMake(radius, radius*2+rect.size.height-2*radius-offset)];
    [p addArcWithCenter:CGPointMake(radius, radius+rect.size.height-2*radius-offset) radius:radius startAngle:M_PI_2 endAngle:M_PI clockwise:YES];
    [shadowColor setFill];
    [p fill];
    UIImage*im=UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return im;
}

///打电话
+(void)callPhone:(NSString *)phoneNum delegate:(NSObject *)object
{
    if (phoneNum) {
        NSString *device = [UIDevice currentDevice].model;
        if ([device isEqualToString:@"iPhone"]){
            NSString *num = [[NSString alloc] initWithFormat:@"tel://%@", phoneNum];
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:num]];
        }else{
            UIAlertView * alert=[[UIAlertView alloc]initWithTitle:nil message:@"当前设备不支持打电话" delegate:object cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
        }
    }else{
        UIAlertView * alert=[[UIAlertView alloc]initWithTitle:nil message:@"电话号码错误 ,请您手动拨打" delegate:object cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
    }
    
}
#pragma mark -- 获取验证码
+ (void)getAuthCodeFirstLabel:(UILabel *)firstLabel codeBtn:(UIButton *)codeBtn timeLabel:(UILabel *)timeLabel andbackLabel:(UILabel *)backLabel {
    
    __block int timeout = 59; //倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        if(timeout<=0){ //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                firstLabel.text = @"重发验证码";
                codeBtn.userInteractionEnabled = YES;
                timeLabel.hidden = YES;
                backLabel.hidden = YES;
                firstLabel.hidden = NO;
            });
            
        }else {
            
            int seconds = timeout % 60;
            NSString *strTime = [NSString stringWithFormat:@"%.2d", seconds];
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                codeBtn.userInteractionEnabled = NO;
                timeLabel.text = [NSString stringWithFormat:@"%@",strTime];
                timeLabel.hidden = NO;
                backLabel.hidden = NO;
                firstLabel.hidden = YES;
            });
            timeout--;
        }
    });
    dispatch_resume(_timer);
}
+ (BOOL)validateMobile:(NSString *)mobile {
    
    NSString *phoneRegex =@"^1\\d{10}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phoneTest evaluateWithObject:mobile];
    
}
#pragma mark -- 时间转化
+ (NSString *)conversionTime:(NSString *)time {
    
    NSTimeInterval timeIntrval = [time doubleValue] / 1000.0;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    // 获取此时时间戳长度
    NSTimeInterval nowTimeinterval = [[NSDate date] timeIntervalSince1970];
    int timeInt = nowTimeinterval - timeIntrval; //时间差

    int year = timeInt / (3600 * 24 * 30 * 12);
    int month = timeInt / (3600 * 24 * 30);
    int day = timeInt / (3600 * 24);
    int hour = timeInt / 3600;
    int minute = timeInt / 60;
    
    if (year > 0) {
        
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:timeIntrval];
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy年MM月dd日"];
        NSString *dateString  = [formatter stringFromDate: date];
        return dateString;
        
    }else if(0 < day && day <= 2){

        return [NSString stringWithFormat:@"%d天前",day];

        
    }else if(day > 2){
        
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:timeIntrval];
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"MM月dd日"];
        NSString *dateString  = [formatter stringFromDate: date];
        return dateString;
        
        
    }else if(month > 0){
        
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:timeIntrval];
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"MM月dd日"];
        NSString *dateString  = [formatter stringFromDate: date];
        return dateString;
        
    }else if(hour > 0 && hour < 48){
        
        return [NSString stringWithFormat:@"%d小时前",hour];
        
    }else if(minute > 0 && minute < 60){
        
        return [NSString stringWithFormat:@"%d分钟前",minute];
        
    }else {
        
        return [NSString stringWithFormat:@"刚刚"];
    }
    
}
///一段文字大小设置
//+(NSMutableAttributedString *)iterationTextFontWithText:(NSString *)text andFontSize:(int)fontSize andSubStringAbandonNum:(int)num andWidth:(float)width OtherWidth:(float)otherWidth{
//    int stringLength = (int)text.length;
//    NSString *string = [text substringToIndex:stringLength-num];
//    CGFloat length = [NSString widthOnLabelForString:string WithFont:[UIFont systemFontOfSize:fontSize] withLabelHeight:48];
//    if (length>width-otherWidth*num){
//        return  [self iterationTextFontWithText:text andFontSize:fontSize-1 andSubStringAbandonNum:num andWidth:width OtherWidth:otherWidth];
//    }else{
//        NSMutableAttributedString *attribute = [[NSMutableAttributedString alloc] initWithString:text];
//        [attribute addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:fontSize] range:NSMakeRange(0,stringLength-num)];
//        [attribute addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:otherWidth] range:NSMakeRange(stringLength-num,num)];
//        return attribute;
//    }
//}

@end
