//
//  CXUploadImage.h
//  CXEVlookProject
//
//  Created by MG on 2018/7/4.
//  Copyright © 2018年 CXEVlook. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 上传图片
 */

/**
 定义请求成功的block
 */
typedef void(^requestSuccess)( id response);

/**
 定义请求失败的block
 */
typedef void(^requestFailure)( id response);



@interface CXUploadImage : NSObject



/**
 上传图片

 @param urlString url
 @param paraments    参数
 @param imageData    图片数据
 @param successBlock 成功回调
 @param failureBlock 失败回调
 */
+ (void)uploadImageWithUrlString:(NSString *)urlString
                   withParaments:(NSDictionary *)paraments
                   withImageData:(NSData *)imageData
                withSuccessBlock:(requestSuccess)successBlock
                 withFailurBlock:(requestFailure)failureBlock
               ;

@end
