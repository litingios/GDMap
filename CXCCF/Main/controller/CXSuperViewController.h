//
//  CXSuperViewController.h
//  CXEVlookProject
//
//  Created by qiaowa on 2018/4/9.
//  Copyright © 2018年 CXEVlook. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef NS_ENUM(NSInteger, CXSuperNavigationType) {
    //白色     0
    CXSuperNavigationTypeDefult = 0,
    //透明    1
    CXSuperNavigationTypeClear,
    //灰色    2
    CXSuperNavigationTypeGary,
    
    
};


typedef NS_ENUM(NSInteger, CXNavigationType) {
    //白色     0
    CXNavigationTypeDefult = 0,
    //透明    1
    CXNavigationTypeClear,
    //灰色    2
    CXNavigationTypeGary,
    
    
};


@interface CXSuperViewController : UIViewController
/* 导航栏是否透明 */
@property (nonatomic ,assign) CXNavigationType navitype;
/* 返回按钮 需自定义请重写这个方法 */
-(void)backClikc;

- (CGFloat)cellContentViewWith;
/**
 *  修改状态栏颜色
 */
@property (nonatomic, assign) UIStatusBarStyle StatusBarStyle;


@property (nonatomic, strong) UITableView * tableView;
@property (nonatomic, strong) UICollectionView * collectionView;
@property (nonatomic ,strong) UICollectionViewFlowLayout* flowLayout;


-(void)headerRereshing;

-(void)footerRereshing;
/**
 *  显示没有数据页面
 */
-(void)showNoDataImage;

/**
 *  移除无数据页面
 */
-(void)removeNoDataImage;

/**
 *  加载视图
 */
- (void)showLoadingAnimation;

/**
 *  停止加载
 */
- (void)stopLoadingAnimation;

/**
 *  是否显示返回按钮,默认情况是YES
 */
@property (nonatomic, assign) BOOL isShowLiftBack;

/**
 是否隐藏导航栏
 */
@property (nonatomic, assign) BOOL isHidenNaviBar;

/**
 导航栏添加文本按钮
 
 @param titles 文本数组
 @param isLeft 是否是左边 非左即右
 @param target 目标
 @param action 点击方法
 @param tags tags数组 回调区分用
 */
- (void)addNavigationItemWithTitles:(NSArray *)titles isLeft:(BOOL)isLeft target:(id)target action:(SEL)action tags:(NSArray *)tags;

/**
 导航栏添加图标按钮
 
 @param imageNames 图标数组
 @param isLeft 是否是左边 非左即右
 @param target 目标
 @param action 点击方法
 @param tags tags数组 回调区分用
 */
- (void)addNavigationItemWithImageNames:(NSArray *)imageNames isLeft:(BOOL)isLeft target:(id)target action:(SEL)action tags:(NSArray *)tags;

/**
 *  默认返回按钮的点击事件，默认是返回，子类可重写
 */
- (void)backBtnClicked;

//取消网络请求
- (void)cancelRequest;
@end
