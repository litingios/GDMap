//
//  AFHTTPClient.h
//  HelloTest
//
//  Created by qiaowandong on 2016/10/17.
//  Copyright © 2016年 qiao. All rights reserved.
//
#import "Custom.h"
//#import "GSKeyChainDataManager.h"

@implementation Custom

+ (NSString *)timeFromTimestamp:(NSInteger)timestamp{
    
    NSDateFormatter *dateFormtter =[[NSDateFormatter alloc] init];
    NSDate *d = [NSDate dateWithTimeIntervalSince1970:timestamp];
    NSTimeInterval late=[d timeIntervalSince1970]*1;    //转记录的时间戳
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval now=[dat timeIntervalSince1970]*1;   //获取当前时间戳
    NSString *timeString=@"";
    NSTimeInterval cha=now-late;
    // 发表在一小时之内
    if (cha/3600<1) {
        if (cha/60<1) {
            timeString = @"1";
        }
        else
        {
            timeString = [NSString stringWithFormat:@"%f", cha/60];
            timeString = [timeString substringToIndex:timeString.length-7];
        }
        
        timeString=[NSString stringWithFormat:@"%@分钟前", timeString];
    }
    // 在一小时以上24小以内
    else if (cha/3600>1&&cha/86400<1) {
        timeString = [NSString stringWithFormat:@"%f", cha/3600];
        timeString = [timeString substringToIndex:timeString.length-7];
        timeString=[NSString stringWithFormat:@"%@小时前", timeString];
    }
    // 发表在24以上10天以内
    else if (cha/86400>1&&cha/86400*3<1)     //86400 = 60(分)*60(秒)*24(小时)   3天内
    {
        timeString = [NSString stringWithFormat:@"%f", cha/86400];
        timeString = [timeString substringToIndex:timeString.length-7];
        timeString=[NSString stringWithFormat:@"%@天前", timeString];
    }
    // 发表时间大于10天
    else
    {
        [dateFormtter setDateFormat:@"yyyy-MM-dd"];
        timeString = [dateFormtter stringFromDate:d];
    }
    
    return timeString;
}



+(NSString*)encodeString:(NSString*)unencodedString{
    
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

+(NSString *)reviseString:(NSString *)str
{
    //直接传入精度丢失有问题的Double类型
    double conversionValue = [str doubleValue];
    NSString *doubleString = [NSString stringWithFormat:@"%lf", conversionValue];
    NSDecimalNumber *decNumber = [NSDecimalNumber decimalNumberWithString:doubleString];
    return [decNumber stringValue];
}
+ (UIImage *)buttonImageFromColor:(UIColor *)color{
    
    CGRect rect = CGRectMake(0, 0, 0.5, 0.5);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext(); return img;
}
+ (void)messageWithString:(NSString *)aString {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:aString delegate:nil cancelButtonTitle:@"确定"
                                          otherButtonTitles:nil];
    [alert show];
//    CustomIOS7AlertView *alertView = [[CustomIOS7AlertView alloc] initWithButtonTitle:@"好"
//                                                                         contentTitle:aString];
//    [alertView show];
}

+ (void)messageWithString:(NSString *)aString title:(NSString *)title {

//    CustomIOS7AlertView *alertView = [[CustomIOS7AlertView alloc] initWithButtonTitle:title
//                                                                         contentTitle:aString];
//    [alertView show];
}

+ (NSMutableArray *)loadPlistName:(NSString *)name {
    
    NSString *path = [[NSBundle mainBundle] pathForResource:name ofType:@"plist"];
    return [NSMutableArray arrayWithContentsOfFile:path];
}

+ (void)setBorder:(UIView *)sender {
	
	[sender.layer setBorderColor:[UIColor whiteColor].CGColor];
	[sender.layer setMasksToBounds:YES];
	[sender.layer setCornerRadius:3];
	[sender.layer setBorderWidth:0.5];
}

+ (void)setShadow:(UIView *)sender {

	sender.layer.shadowOffset = CGSizeMake(0, 10);
	sender.layer.shadowOpacity = 1.1f;
	sender.layer.shadowColor = [UIColor blackColor].CGColor;
}

+ (NSString *)getDocumentDir {

	return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES) objectAtIndex:0];
}


+ (NSString *)formatPhoneNum:(NSString *)phone
{
    if ([phone hasPrefix:@"86"]) {
        NSString *formatStr = [phone substringWithRange:NSMakeRange(2, [phone length]-2)];
        return formatStr;
    }
    else if ([phone hasPrefix:@"+86"])
    {
        if ([phone hasPrefix:@"+86·"]) {
            NSString *formatStr = [phone substringWithRange:NSMakeRange(4, [phone length]-4)];
            return formatStr;
        }else if ([phone hasPrefix:@"+86 "])
        {
            NSString *formatStr = [phone substringWithRange:NSMakeRange(4, [phone length]-4)];
            return formatStr;
        }
        else
        {
            NSString *formatStr = [phone substringWithRange:NSMakeRange(3, [phone length]-3)];
            return formatStr;
        }
    }
    return phone;
}
+ (UIImage *)gradientColorImageFromColors:(NSArray*)colors gradientType:(GradientType)gradientType imgSize:(CGSize)imgSize
{
    NSMutableArray *ar = [NSMutableArray array];
    for(UIColor *c in colors) {
        [ar addObject:(id)c.CGColor];
    }
    UIGraphicsBeginImageContextWithOptions(imgSize, YES, 1);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    CGColorSpaceRef colorSpace = CGColorGetColorSpace([[colors lastObject] CGColor]);
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (CFArrayRef)ar, NULL);
    CGPoint start;
    CGPoint end;
    switch (gradientType) {
        case GradientTypeTopToBottom:
            start = CGPointMake(0.0, 0.0);
            end = CGPointMake(0.0, imgSize.height);
            break;
        case GradientTypeLeftToRight:
            start = CGPointMake(0.0, 0.0);
            end = CGPointMake(imgSize.width, 0.0);
            break;
        case GradientTypeUpleftToLowright:
            start = CGPointMake(0.0, 0.0);
            end = CGPointMake(imgSize.width, imgSize.height);
            break;
        case GradientTypeUprightToLowleft:
            start = CGPointMake(imgSize.width, 0.0);
            end = CGPointMake(0.0, imgSize.height);
            break;
        default:
            break;
    }
    CGContextDrawLinearGradient(context, gradient, start, end, kCGGradientDrawsBeforeStartLocation | kCGGradientDrawsAfterEndLocation);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    CGGradientRelease(gradient);
    CGContextRestoreGState(context);
    CGColorSpaceRelease(colorSpace);
    UIGraphicsEndImageContext();
    return image;
}

+(UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size
{
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}


+ (BOOL)validateTelephoneNumber:(NSString *)telNum
{
    /**
     
     * 大陆地区固话及小灵通
     
     * 区号：010,020,021,022,023,024,025,027,028,029
     
     * 号码：七位或八位
     
     * 例:021-23450623
     
     */
    
    NSString *regexp_tel = @"^0(10|2[0-5789]|\\d{3})-?\\d{7,8}$";
    
    /**
     
     * 中国联通
     
     * 130,131,132,145,155,156,170,171,175,176,185,186
     
     */
    
    NSString *regexp_chinaunicom = @"^1(3[0-2]|4[45]|5[256]|7[01456]|8[56])\\d{8}$";
    
    /**
     
     * 中国电信
     
     * 133,149,153,170,173,177,180,181,189
     
     */
    
    NSString *regexp_chinatelecom = @"^1(33|49|53|7[037]|8[019])\\d{8}$";
    
    /**
     
     * 中国移动
     
     * 134,135,136,137, 138,139,147,150,151, 152,157,158,159,178,182,183,184,187,188
     
     */
    //    10.10.0.0--10.10.65.254   10.20.0.0--10.20.22.254  192.168.2.0--192.168.2.254  192.168.8.0--192.168.12.254
    
    //    NSString *regexp_ip_1 = @"^10.10.[0-65].[0-254]$";
    //    NSString *regexp_ip_2 = @"^10.20.[0-22].[0-254]$";
    //    NSString *regexp_ip_3 = @"^192.168.2.[0-254]$";
    //    NSString *regexp_ip_4 = @"^192.168.[8-12].[0-254]$";
    //    NSPredicate *validate_tel_1 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regexp_ip_1];
    //    NSPredicate *validate_tel_2 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regexp_ip_2];
    //    NSPredicate *validate_tel_3 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regexp_ip_3];
    //    NSPredicate *validate_tel_4 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regexp_ip_4];
    
    NSString *regexp_chinamobile = @"^1(3[4-9]|4[7]|5[0127-9]|7[8]|8[23478])\\d{8}$";
    
    NSString *regexp_allMoble = @"^1[3|4|5|7|8][0-9]{9}$";
    
    NSPredicate *validate_tel = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regexp_tel];
    
    NSPredicate *validate_chinaunicom = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regexp_chinaunicom];
    
    NSPredicate *validate_chinatelecom = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regexp_chinatelecom];
    
    NSPredicate *validate_chinamobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regexp_chinamobile];
    
    NSPredicate *validate_allmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regexp_allMoble];
    return
    
    [validate_tel evaluateWithObject:telNum] ||
    
    [validate_chinaunicom evaluateWithObject:telNum] ||
    
    [validate_chinatelecom evaluateWithObject:telNum] ||
    
    [validate_chinamobile evaluateWithObject:telNum]||[validate_allmobile evaluateWithObject:telNum];
}
+ (NSString *)getTempDir {
    
    return NSTemporaryDirectory();
}



+ (NSDate *)getSystemTime {
	
	NSTimeZone *zone = [NSTimeZone defaultTimeZone];
	NSTimeInterval t = [zone secondsFromGMTForDate:[NSDate date]];
    NSDate *system   = [[NSDate date] dateByAddingTimeInterval:t];
	return system;
}

+ (NSString *)transformationTimeClock:(NSString *)timeInterval{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"HH:mm"];
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:[timeInterval intValue]];
    return [formatter stringFromDate:confromTimesp];
}
+ (NSString *)transformationTime:(NSString *)timeInterval{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"YYYY.MM.dd"];
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:[timeInterval intValue]];
    return [formatter stringFromDate:confromTimesp];
}
+ (NSString *)transformationDate:(NSString *)timeInterval timestr:(NSString *)formatstr{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:formatstr];
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:[timeInterval intValue]];
    return [formatter stringFromDate:confromTimesp];
}
+ (NSString *)transformationTimeInterval:(NSDate *)time{
    return [NSString stringWithFormat:@"%ld", (long)[time timeIntervalSince1970]];
}
+ (NSString *)MD5:(NSString *)str {
	
    const char* input = [str UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(input, (CC_LONG)strlen(input), result);
    
    NSMutableString *digest = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for (NSInteger i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [digest appendFormat:@"%02x", result[i]];
    }
    
    return digest;

}
+(UIImage*)convertViewToImage:(NSString *)title{
    UIView *view = get_ViewNoSuperViewStyleBase(CGRectMake(0, 0, 50, 50), 1, HexColor(@"0xefefef"));
    
    UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(8, 8, 34, 34)];
    lab.font =  [UIFont fontWithName:@"Helvetica-Bold" size:20];
    lab.textColor = hexColor(0x517957);
    lab.textAlignment = NSTextAlignmentCenter;
    [view addSubview:lab];
    NSString *namestr ;
    if (title.length>=1) {
        namestr = [title substringFromIndex:title.length - 1];
    }else if (title.length == 1){
        namestr = title;
    }else{
        
    }
    lab.text = namestr;
    
    
    
    
    
    CGSize s = view.bounds.size;
    // 下面方法，第一个参数表示区域大小。第二个参数表示是否是非透明的。如果需要显示半透明效果，需要传NO，否则传YES。第三个参数就是屏幕密度了
    UIGraphicsBeginImageContextWithOptions(s, NO, [UIScreen mainScreen].scale);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage*image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}
+ (UIImage *)reSizeImage:(UIImage *)image toSize:(CGSize)reSize
{
    UIGraphicsBeginImageContext(CGSizeMake(reSize.width, reSize.height));
    [image drawInRect:CGRectMake(0, 0, reSize.width, reSize.height)];
    UIImage *reSizeImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return reSizeImage;
}
+ (UIImage *)scaleToSize:(UIImage *)image targetSize:(CGSize)size {

    UIGraphicsBeginImageContext(size);
    CGRect bounds;
    bounds.origin = CGPointZero;
    bounds.size   = size;
    [image drawInRect:bounds];
    UIImage *resultImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return resultImage;
}
+ (NSData *)compressOriginalImage:(UIImage *)image toMaxDataSizeKBytes:(CGFloat)size{
    NSData * data = UIImageJPEGRepresentation(image, 1.0);
    CGFloat dataKBytes = data.length/1000.0;
    CGFloat maxQuality = 0.9f;
    CGFloat lastData = dataKBytes;
    while (dataKBytes > size && maxQuality > 0.01f) {
        maxQuality = maxQuality - 0.01f;
        data = UIImageJPEGRepresentation(image, maxQuality);
        dataKBytes = data.length / 1000.0;
        if (lastData == dataKBytes) {
            break;
        }else{
            lastData = dataKBytes;
        }
    }
    return data;
}

+(id)JSONValue:(NSData *)data;
{
    __autoreleasing NSError* error = nil;
    id result = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    if (error != nil) return nil;
    return result;
}
+ (UIFont *)systemFont:(CGFloat)size {
    
    return [UIFont systemFontOfSize:size];
    
}

+ (UIFont *)systemFontBold:(CGFloat)size {
    
    return [UIFont fontWithName:@"Helvetica-Bold" size:size];
    
}

+ (UINavigationController *)defaultNavigationController:(UIViewController *)rootViewController {

    UINavigationController *navigation = [[UINavigationController alloc] initWithRootViewController:rootViewController];
    
    CGFloat version = [[[UIDevice currentDevice] systemVersion] floatValue];
    if (version < 7.0 && version > 4.0)
    {
        [navigation.navigationBar setBackgroundImage:[UIImage imageNamed:@"C01"]
                                       forBarMetrics:UIBarMetricsDefault];
    }
    else
    {
//        navigation.navigationBar.barTintColor = MainColor;
        navigation.navigationBar.translucent = NO;
        navigation.navigationBar.tintColor = [UIColor whiteColor];
        navigation.navigationBar.barStyle = UIBarStyleBlackTranslucent;
    }
    return navigation;
}


//+(OutOfSeverVeiw *)addTipsView:(int)tips imgStr:(int)imgstr vc:(UIViewController *)vc
//{
//    OutOfSeverVeiw * oos = [[NSBundle mainBundle]loadNibNamed:@"OutOfSeverView" owner:self options:nil].lastObject;
//    oos.Y = 0;
//    
//    if (tips == 0) {
//        oos.tips.text = @"网络出错了，请小主刷新再试试";
//        oos.img.image = [UIImage imageNamed:@"discounet"];
//    }else{
//        oos.tips.text = @"暂无内容";
//        oos.img.image = [UIImage imageNamed:@"nothing"];
//        [oos.reloadBtn setTitle:@"点击刷新" forState:UIControlStateNormal];
//    }
//    
//    
//    oos.reloadBtn.Y = oos.reloadBtn.frame.origin.y - 100;
//    
//    [vc.view addSubview:oos];
//    
//    return  oos;
//}




+ (NSString *)getSystemWIFIMAC{
//    NSArray *ifs = (__bridge_transfer NSArray *)CNCopySupportedInterfaces();
//    NSDictionary *info = nil;
//    for (NSString *ifnam in ifs) {
//        info = (__bridge_transfer NSDictionary *)CNCopyCurrentNetworkInfo((__bridge CFStringRef)ifnam);
//        if (info && [info count]) {
//            break;
//        }
//    }
//    return info[@"BSSID"];
    
//    int         mib[6];
//    size_t       len;
//    char        *buf;
//    unsigned char    *ptr;
//    struct if_msghdr  *ifm;
//    struct sockaddr_dl *sdl;
//    
//    mib[0] = CTL_NET;
//    mib[1] = AF_ROUTE;
//    mib[2] = 0;
//    mib[3] = AF_LINK;
//    mib[4] = NET_RT_IFLIST;
//    
//    if ((mib[5] = if_nametoindex("en0")) == 0) {
//        printf("Error: if_nametoindex error/n");
//        return NULL;
//    }
//    
//    if (sysctl(mib, 6, NULL, &len, NULL, 0) < 0) {
//        printf("Error: sysctl, take 1/n");
//        return NULL;
//    }
//    
//    if ((buf = malloc(len)) == NULL) {
//        printf("Could not allocate memory. error!/n");
//        return NULL;
//    }
//    
//    if (sysctl(mib, 6, buf, &len, NULL, 0) < 0) {
//        printf("Error: sysctl, take 2");
//        return NULL;
//    }
//    
//    ifm = (struct if_msghdr *)buf;
//    sdl = (struct sockaddr_dl *)(ifm + 1);
//    ptr = (unsigned char *)LLADDR(sdl);
//    NSString *outstring = [NSString stringWithFormat:@"%02x:%02x:%02x:%02x:%02x:%02x", *ptr, *(ptr+1), *(ptr+2), *(ptr+3), *(ptr+4), *(ptr+5)];
//    NSLog(@"outString:%@", outstring);
//    
//    free(buf); 
//    
//    return [outstring uppercaseString];
    
    int         mgmtInfoBase[6];
    char        *msgBuffer = NULL;
    size_t       length;
    unsigned char    macAddress[6];
    struct if_msghdr  *interfaceMsgStruct;
    struct sockaddr_dl *socketStruct;
    NSString      *errorFlag = NULL;
    
    // Setup the management Information Base (mib)
    mgmtInfoBase[0] = CTL_NET;    // Request network subsystem
    mgmtInfoBase[1] = AF_ROUTE;    // Routing table info
    mgmtInfoBase[2] = 0;
    mgmtInfoBase[3] = AF_LINK;    // Request link layer information
    mgmtInfoBase[4] = NET_RT_IFLIST; // Request all configured interfaces
    
    // With all configured interfaces requested, get handle index
    if ((mgmtInfoBase[5] = if_nametoindex("en0")) == 0)
        errorFlag = @"if_nametoindex failure";
    else
    {
        // Get the size of the data available (store in len)
        if (sysctl(mgmtInfoBase, 6, NULL, &length, NULL, 0) < 0)
            errorFlag = @"sysctl mgmtInfoBase failure";
        else
        {
            // Alloc memory based on above call
            if ((msgBuffer = malloc(length)) == NULL)
                errorFlag = @"buffer allocation failure";
            else
            {
                // Get system information, store in buffer
                if (sysctl(mgmtInfoBase, 6, msgBuffer, &length, NULL, 0) < 0)
                    errorFlag = @"sysctl msgBuffer failure";
            }
        }
    }
    
    // Befor going any further...
    if (errorFlag != NULL)
    {
        NSLog(@"Error: %@", errorFlag);
        return errorFlag;
    }
    
    // Map msgbuffer to interface message structure
    interfaceMsgStruct = (struct if_msghdr *) msgBuffer;
    
    // Map to link-level socket structure
    socketStruct = (struct sockaddr_dl *) (interfaceMsgStruct + 1);
    
    // Copy link layer address data in socket structure to an array
    memcpy(&macAddress, socketStruct->sdl_data + socketStruct->sdl_nlen, 6);
    
    // Read from char array into a string object, into traditional Mac address format
    NSString *macAddressString = [NSString stringWithFormat:@"%02x:%02x:%02x:%02x:%02x:%02x",
                                  macAddress[0], macAddress[1], macAddress[2],
                                  macAddress[3], macAddress[4], macAddress[5]];
    NSLog(@"Mac Address: %@", macAddressString); 
    
    // Release the buffer memory 
    free(msgBuffer); 
    
//    return macAddressString;
    return @"";
}
 //获取WIFIIP的方法
+ (NSString *)getSystemIP{
    NSString *address = @"error";
    struct ifaddrs *interfaces = NULL;
    struct ifaddrs *temp_addr = NULL;
    int success = 0;
    
    // retrieve the current interfaces - returns 0 on success
    success = getifaddrs(&interfaces);
    if (success == 0) {
        // Loop through linked list of interfaces
        temp_addr = interfaces;
        while (temp_addr != NULL) {
            if( temp_addr->ifa_addr->sa_family == AF_INET) {
                // Check if interface is en0 which is the wifi connection on the iPhone
                if ([[NSString stringWithUTF8String:temp_addr->ifa_name] isEqualToString:@"en0"]) {
                    // Get NSString from C String
                    address = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_addr)->sin_addr)];
                }
            }
            temp_addr = temp_addr->ifa_next;
        }
    }
    
    // Free memory
    freeifaddrs(interfaces);
    
    return address;
}

+(NSString *)getWIFIName{
    NSString *wifi_name = nil;
    id info = nil;
    NSArray *ifs = (__bridge_transfer id)CNCopySupportedInterfaces();
    for (NSString *ifnam in ifs) {
        info = (__bridge_transfer id)CNCopyCurrentNetworkInfo((__bridge CFStringRef)ifnam);
        wifi_name = info[@"SSID"];
//        NSString *str2 = info[@"BSSID"];
        NSString *str3 = [[ NSString alloc] initWithData:info[@"SSIDDATA"] encoding:NSUTF8StringEncoding];
        if (wifi_name.length==0) {
            wifi_name = str3;
        }
    }
    return wifi_name;
}
+ (NSString *)splicingAndEncryption:(NSDictionary *)dic{
    
//    NSArray *keys =  [dic allKeys];
//    NSStringCompareOptions comparisonOptions =NSCaseInsensitiveSearch|NSNumericSearch|NSWidthInsensitiveSearch|NSForcedOrderingSearch;
//    NSComparator sort = ^(NSString *obj1,NSString *obj2){
//        NSRange range =NSMakeRange(0,obj1.length);
//        return [obj1 compare:obj2 options:comparisonOptions range:range];
//    };
//    NSArray *resultKeys = [keys sortedArrayUsingComparator:sort];
//    NSString *splicing;
//    for (int i = 0; i < resultKeys.count; i++) {
//        NSString *valueStr = [dic objectForKey:[resultKeys objectAtIndex:i]];
//        if (i == 0) {
//            splicing = [NSString stringWithFormat:@"%@$%@",[resultKeys objectAtIndex:i],valueStr];
//        }else{
//            splicing = [NSString stringWithFormat:@"%@#%@$%@",splicing,[resultKeys objectAtIndex:i],valueStr];
//        }
//    }
//    splicing = [NSString stringWithFormat:@"%@#%@",splicing,SecretKey];
//    return [Custom MD5:splicing];
    return @"hello";
}

+ (UIButton *)creatNavigationRightBtnWithSel:(SEL)sel navigationItem:(UINavigationItem *)navigationitem Title:(NSString *)title Target:(id)target; {
    
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.imageView.contentMode = UIViewContentModeCenter;
    button.frame = CGRectMake(0, 0, 50  , 50);
    //    button setBackgroundColor:[UIColor redColor];
//    [button setTitleColor:UIColorFromRGBA(0x4a4a4a, 1) forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    button.titleLabel.font = [UIFont systemFontOfSize:15.0];
    button.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -26);
    button.titleLabel.textAlignment = NSTextAlignmentRight;
    
    button.exclusiveTouch =YES;
    //    [button setImage:[UIImage imageNamed:@"fatherBack"] forState:UIControlStateNormal];
    [button setTitle:title forState:UIControlStateNormal];
    [button addTarget:target action:sel forControlEvents:UIControlEventTouchDown];
    button.imageEdgeInsets = UIEdgeInsetsMake(0, 25, 0, 0);
    UIBarButtonItem *right = [[UIBarButtonItem alloc]initWithCustomView:button];
    navigationitem.rightBarButtonItem = right;
    return button;
}






+ (NSString *)getAstroWithMonth:(int)m day:(int)d{
    
    NSString *astroString = @"魔羯水瓶双鱼白羊金牛双子巨蟹狮子处女天秤天蝎射手魔羯";
    NSString *astroFormat = @"102123444543";
    NSString *result;
    if (m<1||m>12||d<1||d>31){
        return @"错误日期格式!";
    }
    if(m==2 && d>29)
    {
        return @"错误日期格式!!";
    }else if(m==4 || m==6 || m==9 || m==11) {
        
        if (d>30) {
            return @"错误日期格式!!!";
        }
    }
    result=[NSString stringWithFormat:@"%@座",[astroString substringWithRange:NSMakeRange(m*2-(d < [[astroFormat substringWithRange:NSMakeRange((m-1), 1)] intValue] - (-19))*2,2)]];
    return result;
}

+(SearchBarText *)getSearchBar:(CGRect)rect cornerRadius:(CGFloat)cornerRadius text:(NSString *)text serachIcon:(NSString *)iconName enableText:(BOOL)enable;
{
    UIImage *iconImage = [UIImage imageNamed:iconName];
    UIImageView *searchIcon = [[UIImageView alloc] initWithImage:iconImage];
    searchIcon.frame = CGRectMake(0, 0, 20, 20);
    
    SearchBarText *tv = [[SearchBarText alloc] initWithFrame:rect drawingLeft:searchIcon];
    
    if (enable) {
        tv.placeholder = text;
        tv.enabled = YES;
    }else{
        tv.text = text;
        tv.enabled = NO;
    }
    tv.layer.cornerRadius = cornerRadius;
    tv.leftView = searchIcon;
    
    tv.leftViewMode = UITextFieldViewModeAlways;
    return tv;
    
}

//图片倒置
+ (UIImage *)fixOrientation:(UIImage *)aImage {
    // No-op if the orientation is already correct
    if (aImage.imageOrientation == UIImageOrientationUp)
        return aImage;
    
    // We need to calculate the proper transformation to make the image upright.
    // We do it in 2 steps: Rotate if Left/Right/Down, and then flip if Mirrored.
    CGAffineTransform transform = CGAffineTransformIdentity;
    
    switch (aImage.imageOrientation) {
        case UIImageOrientationDown:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, aImage.size.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, 0);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            break;
            
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, 0, aImage.size.height);
            transform = CGAffineTransformRotate(transform, -M_PI_2);
            break;
        default:
            break;
    }
    
    switch (aImage.imageOrientation) {
        case UIImageOrientationUpMirrored:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
            
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.height, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
        default:
            break;
    }
    
    // Now we draw the underlying CGImage into a new context, applying the transform
    // calculated above.
    CGContextRef ctx = CGBitmapContextCreate(NULL, aImage.size.width, aImage.size.height,
                                             CGImageGetBitsPerComponent(aImage.CGImage), 0,
                                             CGImageGetColorSpace(aImage.CGImage),
                                             CGImageGetBitmapInfo(aImage.CGImage));
    CGContextConcatCTM(ctx, transform);
    switch (aImage.imageOrientation) {
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            // Grr...
            CGContextDrawImage(ctx, CGRectMake(0,0,aImage.size.height,aImage.size.width), aImage.CGImage);
            break;
            
        default:
            CGContextDrawImage(ctx, CGRectMake(0,0,aImage.size.width,aImage.size.height), aImage.CGImage);
            break;
    }
    
    // And now we just create a new UIImage from the drawing context
    CGImageRef cgimg = CGBitmapContextCreateImage(ctx);
    UIImage *img = [UIImage imageWithCGImage:cgimg];
    CGContextRelease(ctx);
    CGImageRelease(cgimg);
    return img;
}
//获取版本号
+ (NSString *)getVersion{
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    
    // app名称
//    NSString *app_Name = [infoDictionary objectForKey:@"CFBundleDisplayName"];
    // app版本
    NSString *app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    return [NSString stringWithFormat:@"%@",app_Version];
    // app build版本
//    NSString *app_build = [infoDictionary objectForKey:@"CFBundleVersion"];
}
+ (UIImage*) createImageWithColor: (UIColor*) color
{
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}


@end
