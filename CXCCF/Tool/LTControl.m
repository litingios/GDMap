//
//  LTControl.m
//  百思不得其解
//
//  Created by 李霆 on 2018/9/15.
//  Copyright © 2018年 李霆. All rights reserved.
//

#import "LTControl.h"
//#import "CXDetailModel.h"
//#import "CXCheckStatesRequest.h"
#import "FLAnimatedImage.h"
#import "FLAnimatedImageView.h"

#define IOS7   [[UIDevice currentDevice]systemVersion].floatValue>=7.0
#define ScreenHeight [[UIScreen mainScreen] bounds].size.height//获取屏幕高度，兼容性测试
#define ScreenWidth [[UIScreen mainScreen] bounds].size.width//获取屏幕宽度，兼容性测试

@implementation LTControl

+(CGRect)createCGRectMakeScale:(CGFloat)x andY:(CGFloat)y andWidth:(CGFloat)width andHeight:(CGFloat)height
{
    CGFloat autoSizeScaleX;
    CGFloat autoSizeScaleY;
    
    if(ScreenHeight > 480){
        autoSizeScaleX = ScreenWidth/320;
        autoSizeScaleY = ScreenHeight/568;
    }else{
        autoSizeScaleX = 1.0;
        autoSizeScaleY = 1.0;
    }
    
    CGRect rect;
    rect.origin.x = x * autoSizeScaleX;
    rect.origin.y = y * autoSizeScaleY;
    rect.size.width = width * autoSizeScaleX;
    rect.size.height = height * autoSizeScaleY;
    return rect;
}

+(CGPoint)createCGPointMakeScale:(CGFloat)x andY:(CGFloat)y
{
    CGFloat autoSizeScaleX;
    CGFloat autoSizeScaleY;
    
    if(ScreenHeight > 480){
        autoSizeScaleX = ScreenWidth/320;
        autoSizeScaleY = ScreenHeight/568;
    }else{
        autoSizeScaleX = 1.0;
        autoSizeScaleY = 1.0;
    }
    
    CGPoint point;
    point.x = x * autoSizeScaleX;
    point.y = y * autoSizeScaleY;
    return point;
}

+(CGSize)createCGSizeMakeScale:(CGFloat)width andHeight:(CGFloat)height
{
    CGFloat autoSizeScaleX;
    CGFloat autoSizeScaleY;
    
    if(ScreenHeight > 480){
        autoSizeScaleX = ScreenWidth/320;
        autoSizeScaleY = ScreenHeight/568;
    }else{
        autoSizeScaleX = 1.0;
        autoSizeScaleY = 1.0;
    }
    
    CGSize size;
    size.width = width * autoSizeScaleX;
    size.height = height * autoSizeScaleY;
    return size;
}

+(void)createModelFromDictionary:(NSDictionary *)dict className:(NSString *)className
{
    //创建数据模型
    printf("@interface  %s : NSObject\n",className.UTF8String);
    for (NSString *key in dict)
    {
        printf("@property (copy,nonatomic) NSString *%s;\n",key.UTF8String);
    }
    printf("@end\n");
}
+(UILabel*)createLineLabWithFrame:(CGRect)frame{
    UILabel*label=[[UILabel alloc]initWithFrame:frame];
    label.backgroundColor = [UIColor grayColor];
    return label;
}
+(UILabel*)createLabelWithFrame:(CGRect)frame Font:(int)font Text:(NSString*)text
{
    
    
    UILabel*label=[[UILabel alloc]initWithFrame:frame];
    //限制行数
    label.numberOfLines=0;
    //对齐方式
    label.textAlignment=NSTextAlignmentLeft;
    label.backgroundColor=[UIColor clearColor];
    label.font=[UIFont systemFontOfSize:font];
    //单词折行
    label.lineBreakMode=NSLineBreakByWordWrapping;
    //默认字体颜色是白色
    label.textColor=[UIColor blackColor];
    //自适应（行数~字体大小按照设置大小进行设置）
    label.adjustsFontSizeToFitWidth=YES;
    label.text=text;
    return label;
}
+(UIButton*)createButtonWithFrame:(CGRect)frame ImageName:(NSString*)imageName Target:(id)target Action:(SEL)action Title:(NSString*)title
{
    UIButton*button=[UIButton buttonWithType:UIButtonTypeCustom];
    button.frame=frame;
    [button setTitle:title forState:UIControlStateNormal];
    //设置背景图片，可以使文字与图片共存
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal ] ;  //图片与文字如果需要同时存在，就需要图片足够小 详见人人项目按钮设置
    // [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    button.titleLabel.font = [UIFont systemFontOfSize:16];
    return button;
    
    
}
//文字在左图片在右
+(UIButton*)createRightButtonWithFrame:(CGRect)frame ImageName:(NSString*)imageName Target:(id)target Action:(SEL)action Title:(NSString*)title{
    UIButton*button=[UIButton buttonWithType:UIButtonTypeCustom];
    button.frame=frame;
    [button setTitle:title forState:UIControlStateNormal];
    //设置背景图片，可以使文字与图片共存
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal ] ;  //图片与文字如果需要同时存在，就需要图片
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    CGFloat imageWidth = button.imageView.bounds.size.width;
    CGFloat labelWidth = button.titleLabel.bounds.size.width;
    button.imageEdgeInsets = UIEdgeInsetsMake(0, labelWidth, 0, -labelWidth);
    button.titleEdgeInsets = UIEdgeInsetsMake(0, -imageWidth, 0, imageWidth);
    button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    return button;
}
+(UIButton*)createButtonWithFrame:(CGRect)frame ImageName:(NSString*)imageName Title:(NSString*)title Font:(CGFloat)font TitleColor:(UIColor *)color BackgroundColor:(UIColor *)backgroundColor
{
    UIButton*button=[UIButton buttonWithType:UIButtonTypeCustom];
    button.frame=frame;
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:color forState:UIControlStateNormal];
    button.backgroundColor = backgroundColor;
    button.titleLabel.font = [UIFont systemFontOfSize:font];
    //设置背景图片，可以使文字与图片共存
    [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal ] ;
    
    return button;
    
    
}
+(UIImageView*)createImageViewWithFrame:(CGRect)frame ImageName:(NSString*)imageName
{
    UIImageView*imageView=[[UIImageView alloc]initWithFrame:frame];
    imageView.image=[UIImage imageNamed:imageName];
    imageView.userInteractionEnabled=YES;
    return imageView ;
}
+(UIView*)viewWithFrame:(CGRect)frame
{
    UIView*view=[[UIView alloc]initWithFrame:frame];
    
    return view ;
    
}
+(UITextField*)createTextFieldWithFrame:(CGRect)frame placeholder:(NSString*)placeholder passWord:(BOOL)YESorNO leftImageView:(UIImageView*)imageView rightImageView:(UIImageView*)rightImageView Font:(float)font
{
    UITextField*textField=[[UITextField alloc]initWithFrame:frame];
    //灰色提示框
    textField.placeholder=placeholder;
    //文字对齐方式
    textField.textAlignment=NSTextAlignmentLeft;
    textField.secureTextEntry=YESorNO;
    //边框
    //textField.borderStyle=UITextBorderStyleLine;
    //键盘类型
    textField.keyboardType=UIKeyboardTypeEmailAddress;
    //关闭首字母大写
    textField.autocapitalizationType=NO;
    //清除按钮
    textField.clearButtonMode=YES;
    //左图片
    textField.leftView=imageView;
    textField.leftViewMode=UITextFieldViewModeAlways;
    //右图片
    textField.rightView=rightImageView;
    //编辑状态下一直存在
    textField.rightViewMode=UITextFieldViewModeWhileEditing;
    //自定义键盘
    //textField.inputView
    //字体
    textField.font=[UIFont systemFontOfSize:font];
    //字体颜色
    textField.textColor=[UIColor grayColor];
    return textField ;
    
}
#pragma  mark 适配器方法
+(UITextField*)createTextFieldWithFrame:(CGRect)frame placeholder:(NSString*)placeholder passWord:(BOOL)YESorNO leftImageView:(UIImageView*)imageView rightImageView:(UIImageView*)rightImageView Font:(float)font backgRoundImageName:(NSString*)imageName
{
    UITextField*text= [self createTextFieldWithFrame:frame placeholder:placeholder passWord:YESorNO leftImageView:imageView rightImageView:rightImageView Font:font];
    text.background=[UIImage imageNamed:imageName];
    return  text;
    
}
+(UITextField*)createTextFieldWithFrame:(CGRect)frame placeholder:(NSString*)placeholder KeyboardType:(UIKeyboardType)keyboardType Font:(float)font PlaceColor:(UIColor *)color{
    UITextField*textField=[[UITextField alloc]initWithFrame:frame];
    //灰色提示框
    textField.placeholder=placeholder;
    textField.keyboardType=keyboardType;
    textField.clearButtonMode=NO;
    textField.textColor = [UIColor whiteColor];
    textField.tintColor = [UIColor blackColor];
    textField.font = FONT(font);
    [textField setValue:[UIColor grayColor] forKeyPath:@"_placeholderLabel.textColor"];
    return textField;
}

+(UIScrollView*)makeScrollViewWithFrame:(CGRect)frame andSize:(CGSize)size
{
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:frame];
    
    scrollView.pagingEnabled = YES;
    scrollView.contentSize = size;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.scrollsToTop = NO;
    return scrollView ;
}

+(UIScrollView *)createUIScrollViewWithFrame:(CGRect)frame contentSize:(CGSize)size pagingEnabled:(BOOL)pagingEnabled showsHorizontalScrollIndicator:(BOOL)showsHorizontalScrollIndicator showsVerticalScrollIndicator:(BOOL)showsVerticalScrollIndicator delegate:(id)delegate
{
    UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:frame];
    scrollView.contentSize = size;
    scrollView.pagingEnabled = pagingEnabled;
    scrollView.showsHorizontalScrollIndicator = showsHorizontalScrollIndicator;
    scrollView.showsVerticalScrollIndicator = showsVerticalScrollIndicator;
    if (delegate != nil) {
        scrollView.delegate = delegate;
    }
    return scrollView;
}

+(UIPageControl*)makePageControlWithFram:(CGRect)frame
{
    UIPageControl *pageControl = [[UIPageControl alloc] initWithFrame:frame];
    pageControl.numberOfPages = 2;
    pageControl.currentPage = 0;
    return pageControl;
}
+(UISlider*)makeSliderWithFrame:(CGRect)rect AndImage:(UIImage*)image
{
    UISlider *slider = [[UISlider alloc]initWithFrame:rect];
    slider.minimumValue = 0;
    slider.maximumValue = 1;
    [slider setThumbImage:[UIImage imageNamed:@"qiu"] forState:UIControlStateNormal];
    slider.maximumTrackTintColor = [UIColor grayColor];
    slider.minimumTrackTintColor = [UIColor yellowColor];
    slider.continuous = YES;
    slider.enabled = YES;
    return slider ;
}
+(NSString *)stringFromDateWithHourAndMinute:(NSDate *)date
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //zzz表示时区，zzz可以删除，这样返回的日期字符将不包含时区信息。
    [dateFormatter setDateFormat:@"HH:mm"];
    NSString *destDateString = [dateFormatter stringFromDate:date];
    
    return destDateString;
}

#pragma -mark 判断导航的高度
+(float)isIOS7{
    
    float height;
    if (IOS7) {
        height=64.0;
    }else{
        height=44;
    }
    
    return height;
}

#pragma mark 内涵图需要的方法
+ (NSString *)stringDateWithTimeInterval:(NSString *)timeInterval
{
    NSTimeInterval seconds = [timeInterval integerValue];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:seconds];
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    format.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    return [format stringFromDate:date];
}

+ (CGFloat)textHeightWithString:(NSString *)text width:(CGFloat)width fontSize:(NSInteger)fontSize
{
    NSDictionary *dict = @{NSFontAttributeName: [UIFont systemFontOfSize:fontSize]};
    // 根据第一个参数的文本内容，使用280*float最大值的大小，使用系统14号字，返回一个真实的frame size : (280*xxx)!!
    CGRect frame = [text boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil];
    return frame.size.height + 5;
}

// 返回一个整数字符串加1后的新字符串
+ (NSString *)addOneByIntegerString:(NSString *)integerString
{
    NSInteger integer = [integerString integerValue];
    return [NSString stringWithFormat:@"%d",(int)(integer+1)];
}
//返回searchBar
+(UISearchBar*)createSearchBarWithFrame:(CGRect)frame placeholder:(NSString *)placeholder  backImagName:(NSString *)imageName{
    UISearchBar *search = [[UISearchBar alloc]initWithFrame:frame];
    search.placeholder = placeholder;
    [search setSearchFieldBackgroundImage:[UIImage imageNamed:imageName]
                                 forState:UIControlStateNormal];
    
    search.returnKeyType = UIReturnKeySearch;
    return search;
    
}
+(NSMutableAttributedString *)attTextWithTextStr:(NSString *)textStr FontSize:(CGFloat)fontSize ImageStr:(NSString *)imageStr IsQuesLab:(BOOL)isQuesLab{
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:textStr];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:10];//调整行间距
    if (isQuesLab) {
        NSTextAttachment *attch = [[NSTextAttachment alloc] init];
        attch.image = [UIImage imageNamed:imageStr];
        attch.bounds = CGRectMake(0, 0, fontSize*2, fontSize);
        NSAttributedString *string = [NSAttributedString attributedStringWithAttachment:attch];
        [attributedString insertAttributedString:string atIndex:0];
        NSAttributedString *string1 = [[NSAttributedString alloc]initWithString:@"  "];
        [attributedString insertAttributedString:string1 atIndex:1];
    }
    CGFloat textLength = isQuesLab?textStr.length+3:textStr.length;
    [attributedString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:fontSize] range:NSMakeRange(0, textLength)];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, textLength)];
    [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(0, textLength)];
    return attributedString;
}
+ (NSString *)loadWebHtmlStr:(NSString *)h5Str{
    NSString *htmls = [NSString stringWithFormat:@"<html> \n"
                       "<head> \n"
                       "<style type=\"text/css\"> \n"
                       "body {font-size:12px;color:#7f7f7f}\n"
                       "p {line-height:2em;}\n"
                       "img {width: 100%%}\n"
                       "</style> \n"
                       "</head> \n"
                       "<body>"
                       "<script type='text/javascript'>"
                       "</script>%@"
                       "</body>"
                       "</html>",h5Str];
    return htmls;
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

#pragma mark -- 校验邮箱
+ (BOOL)validateEmail:(NSString *)email{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

#pragma mark --------- 字典转json串
+ (NSString *)UIUtilsFomateJsonWithDictionary:(NSDictionary *)dic{
    NSArray *keys = [dic allKeys];
    NSString *string = [NSString string];
    for (NSString *key in keys) {
        NSString *value = [dic objectForKey:key];
        value = [NSString stringWithFormat:@"\"%@\"",value];
        NSString *newkey = [NSString stringWithFormat:@"\"%@\"",key];
        if (!string.length) {
            string = [NSString stringWithFormat:@"%@:%@}",newkey,value];
        }else {
            string = [NSString stringWithFormat:@"%@:%@,%@",newkey,value,string];
        }
    }
    string = [NSString stringWithFormat:@"{%@",string];
    return string;
}

+ (NSString*)encodeString:(NSString*)unencodedString{
    
    // CharactersToBeEscaped = @":/?&=;+!@#$()~',*";
    // CharactersToLeaveUnescaped = @"[].";
    
    NSString *encodedString = (NSString *)
    CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                              (CFStringRef)[NSString stringWithFormat:@"%@",unencodedString],
                                                              NULL,
                                                              (CFStringRef)@"!*'();:@&=+$,/?%#[]",
                                                              kCFStringEncodingUTF8));
    
    return encodedString;
}

//+ (void)checkOutPassWithArr:(NSArray *)arr success:(void(^)(int code))success failure:(void (^)(int code))failure{
//    if (arr.count == 0) {
//        return;
//    }
//    NSMutableArray * arrID = [NSMutableArray array];
//    for (CXDetailModel *model in arr) {
//        [arrID addObject:model.id];
//    }
//    NSString *str = [arrID componentsJoinedByString:@","];//#为分隔符
//    CXCheckStatesRequest * request = [[CXCheckStatesRequest alloc]initWithCheckStatesWithCheckStatus:@"0" AndWorkIds:str AndToken:Token AndAudit:@""];
//    [request startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
//        if ([request.responseObject[@"code"] intValue] == CodeSussess) {
//            success([request.responseObject[@"code"] intValue]);
//            [CXAlert showMessage:request.responseObject[@"msg"] Time:0];
//        }else{
////            failure([request.responseObject[@"code"] intValue]);
//            [CXAlert showMessage:request.responseObject[@"msg"] Time:0];
//        }
//    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
//        failure([request.responseObject[@"code"] intValue]);
//    }];
//}

+(void)sd_imageForGiforCommonWithImageView:(FLAnimatedImageView *)imageView andUrl:(NSString *)urlStr{
    if ([urlStr isEqualToString:@""] || urlStr == nil) {
        return;
    }
    if ([urlStr hasSuffix:@"gif"]||[urlStr hasPrefix:@"GIF"]) {
       FLAnimatedImage*fimage = [[FLAnimatedImage alloc]initWithAnimatedGIFData:[NSData dataWithContentsOfURL:[NSURL URLWithString:urlStr]]];
        imageView.animatedImage = fimage;
    }else{
        [imageView sd_setImageWithURL:[NSURL URLWithString:urlStr] placeholderImage:nil];
    }
}

@end
