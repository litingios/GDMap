//
//  CXAlert.h
//  CarMessage
//
//  Created by 李霆 on 2018/5/18.
//  Copyright © 2018年 车讯. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CXAlert : NSObject
+ (void)showMessage:(NSString *)message andTrueoOrFalse:(BOOL )states Time:(double)time;

+(void)showCenterMessage:(NSString *)message Time:(double)time;
    


+(void)collectionCenterMessage:(NSString *)message Time:(double)time;

    
@end
