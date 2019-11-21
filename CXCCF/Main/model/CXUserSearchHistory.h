//
//  CXUserSearchHistory.h
//  CXEVlookProject
//
//  Created by qiaowa on 2018/4/13.
//  Copyright © 2018年 CXEVlook. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CXUserSearchHistory : NSObject
@property (nonatomic ,strong) NSString* token;
@property (nonatomic ,strong) NSString* searchHistory;
@property (nonatomic ,strong) NSString* timeStamp;
@end
