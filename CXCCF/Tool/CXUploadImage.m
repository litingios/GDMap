//
//  CXUploadImage.m
//  CXEVlookProject
//
//  Created by MG on 2018/7/4.
//  Copyright © 2018年 CXEVlook. All rights reserved.
//

#import "CXUploadImage.h"

@implementation CXUploadImage

#pragma mark -- 图片上传
+ (void)uploadImageWithUrlString:(NSString *)urlString
                   withParaments:(NSDictionary *)paraments
                   withImageData:(NSData *)imageData
                withSuccessBlock:(requestSuccess)successBlock
                 withFailurBlock:(requestFailure)failureBlock {
    
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //接收类型不一致请替换一致text/html或别的
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/html",@"image/jpeg",@"image/png",@"application/octet-stream",@"text/json",@"text/plain",nil];
    
    [manager POST:urlString parameters:paraments constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"yyyyMMddHHmmss";
        NSString *str = [formatter stringFromDate:[NSDate date]];
        NSString *fileName = [NSString stringWithFormat:@"%@.jpg", str];
        [formData appendPartWithFileData:imageData
                                    name:@"file"
                                fileName:fileName
                                mimeType:@"image/jpeg"];
        
    } progress:nil
          success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
              
              if (successBlock) {
                  
                  successBlock(responseObject);
                  
              }
              
          } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
              
              if (failureBlock) {
                  
                  failureBlock(error);
              }
              
          }];
    
    
    
    
}
@end
