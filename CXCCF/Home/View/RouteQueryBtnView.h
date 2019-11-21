//
//  RouteQueryBtnView.h
//  CXCCF
//
//  Created by 李霆 on 2019/3/15.
//  Copyright © 2019年 CX. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol RouteQueryDelegate <NSObject>
@optional

- (void)projectBtnCiledWithBtn:(UIButton *)btn;

@end

NS_ASSUME_NONNULL_BEGIN

@interface RouteQueryBtnView : UIView

/*** titleArr ****/
@property(nonatomic,strong) NSArray *titleArr;
- (void)creatBtnData:(NSArray *)titleArr andIndexPath:(NSInteger )index andType:(int )type;

/*** 代理 ****/
@property(nonatomic,weak)id<RouteQueryDelegate>delegate;


@end

NS_ASSUME_NONNULL_END
