//
//  CXMainViewController.m
//  CXEVlookProject
//
//  Created by qiaowa on 2018/3/21.
//  Copyright © 2018年 CXEVlook. All rights reserved.
//

#import "CXMainViewController.h"
#import "HomeController.h"
#import "MineViewController.h"
#import "CarseriseViewController.h"
#import "ActivityViewController.h"

@interface CXMainViewController ()

@end

@implementation CXMainViewController
-(void)viewWillLayoutSubviews{
    
    [super viewWillLayoutSubviews];
//    
//    if (KIsiPhoneX) {
//        
//        for (UITabBarItem *item in self.tabBar.items) {
//            item.imageInsets = UIEdgeInsetsMake(-15,0, 15, 0);
//            [item setTitlePositionAdjustment:UIOffsetMake(0, -34)];
//        }
//    }
}
- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.tabBar.translucent = NO;
    [self initControllers];
}


-(void)initControllers {
    HomeController * newViewController = [[HomeController alloc]init];
    [self addChildVc:newViewController title:@"地图" image:@"ditu_nonal" selectedImage:@"ditu_select"];
    CarseriseViewController * carsetsViewController = [[CarseriseViewController alloc]init];
    [self addChildVc:carsetsViewController title:@"待定" image:@"che_nonal" selectedImage:@"che_select"];
    ActivityViewController * activityViewController = [[ActivityViewController alloc]init];
    [self addChildVc:activityViewController title:@"待定" image:@"huodong_nonal" selectedImage:@"huodong_select"];
    MineViewController * mineViewController = [[MineViewController alloc]init];
    [self addChildVc:mineViewController title:@"待定" image:@"gerenzhongxin_nonal" selectedImage:@"gerenzhongxin_select"];
}

- (void)addChildVc:(UIViewController *)childVc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage {
    
    // 设置子控制器的文字(可以设置tabBar和navigationBar的文字)
    childVc.title = title;
    // 设置子控制器的tabBarItem图片
    childVc.tabBarItem.image = [UIImage imageNamed:image];
    // 禁用图片渲染
    childVc.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    // 设置文字的样式
    [childVc.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName :UIColorFromRGBA(0x666666, 1)} forState:UIControlStateNormal];
    [childVc.tabBarItem setTitleTextAttributes:@{NSFontAttributeName:[Custom systemFont:10]} forState:UIControlStateNormal];
    [childVc.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName :UIColorFromRGBA(0x468ADB, 1)} forState:UIControlStateSelected];
    
    RTRootNavigationController *navigationVc = [[RTRootNavigationController alloc] initWithRootViewController:childVc];
    //    // 添加子控制器
    [self addChildViewController:navigationVc];
    
}

@end
