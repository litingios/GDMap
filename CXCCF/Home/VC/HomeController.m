//
//  HomeController.m
//  CXCCF
//
//  Created by 李霆 on 2019/11/15.
//  Copyright © 2019 CX. All rights reserved.
//

#import "HomeController.h"
#import "HomeTableViewCell.h"

#import "CommonAnnotationVC.h"
#import "LevelAnnotationVC.h"
#import "CustomAnnotationVC.h"

#import "OnlyLineViewController.h"
#import "TheMoreLinesVC.h"
#import "LinsAndPiintsVC.h"
#import "GuiRodesVC.h"

@interface HomeController ()<UITableViewDelegate,UITableViewDataSource>

/***dataArr  ****/
@property(nonatomic,strong) NSMutableArray *dataArr;

@end

@implementation HomeController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = 120*HeightScale;
    self.tableView.mj_header = nil;
    self.tableView.mj_footer = nil;
    self.tableView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight-64-90*HeightScale);
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([HomeTableViewCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([HomeTableViewCell class])];
    [self.view addSubview:self.tableView];
    
    [self creatData];

}

- (void)creatData{
    self.dataArr = [NSMutableArray arrayWithObjects:@"普通大头针显示",@"不同级别的大头针展示",@"自定制大头针展示",@"缩放大头针展示",@"地图画线(在地图范围内自适应展示)",@"多条线以及线切换(类似于路线规划样式)",@"线和点共同展示",@"路线规划及其导航",@"根据自己位置获取周边地址信息", nil];
    [self.tableView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HomeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([HomeTableViewCell class])];
    cell.titleLab.text = self.dataArr[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        CommonAnnotationVC * view = [[CommonAnnotationVC alloc]init];
        view.titleStr = self.dataArr[indexPath.row];
        view.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:view animated:YES];
        
    }else if (indexPath.row == 1){
        LevelAnnotationVC * view = [[LevelAnnotationVC alloc]init];
        view.titleStr = self.dataArr[indexPath.row];
        view.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:view animated:YES];
        
    }else if (indexPath.row == 2){
        CustomAnnotationVC * view = [[CustomAnnotationVC alloc]init];
        view.titleStr = self.dataArr[indexPath.row];
        view.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:view animated:YES];
        
    }else if (indexPath.row == 3){
        
    }else if (indexPath.row == 4){
        OnlyLineViewController * view = [[OnlyLineViewController alloc]init];
        view.titleStr = self.dataArr[indexPath.row];
        view.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:view animated:YES];
        
    }else if (indexPath.row == 5){
        TheMoreLinesVC * view = [[TheMoreLinesVC alloc]init];
        view.titleStr = self.dataArr[indexPath.row];
        view.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:view animated:YES];
        
    }else if (indexPath.row == 6){
        LinsAndPiintsVC * view = [[LinsAndPiintsVC alloc]init];
        view.titleStr = self.dataArr[indexPath.row];
        view.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:view animated:YES];
        
    }else if (indexPath.row == 7){
        GuiRodesVC * view = [[GuiRodesVC alloc]init];
        view.titleStr = self.dataArr[indexPath.row];
        view.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:view animated:YES];
        
    }
}



@end
