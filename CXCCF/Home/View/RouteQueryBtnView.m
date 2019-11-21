
//
//  RouteQueryBtnView.m
//  CXCCF
//
//  Created by 李霆 on 2019/3/15.
//  Copyright © 2019年 CX. All rights reserved.
//

#import "RouteQueryBtnView.h"

@interface RouteQueryBtnView ()
/**  单选按钮选中*/
@property (nonatomic,strong) UIButton *selectedBtn;
/*** <#注释内容#> ****/
@property(nonatomic,assign) NSInteger index;

@end

@implementation RouteQueryBtnView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
    }
    return self;
}

//        [chuLineArray addObject:@{@"polyline":linStr,@"distance":[NSString stringWithFormat:@"%ld",model.distance],@"tolls":[NSString stringWithFormat:@"%.2f",model.tolls],@"duration":[NSString stringWithFormat:@"%ld",model.duration],@"strategy":model.strategy}];

- (void)creatBtnData:(NSArray *)titleArr andIndexPath:(NSInteger )index andType:(int )type{
    self.index = index;
    _titleArr = titleArr;
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    NSArray *fangArray = @[@"方案一",@"方案二",@"方案三"];
    
    for (int i = 0; i <titleArr.count; i++) {
        UIButton *btn = [LTControl createButtonWithFrame:CGRectZero ImageName:nil Target:self Action:@selector(btnCiled:) Title:@""];
        if (type == 1) {
            [btn setTitle:[NSString stringWithFormat:@"%d公里",[titleArr[i] intValue]/1000] forState:UIControlStateNormal];
        }else{
            [btn setTitle:[NSString stringWithFormat:@"%ld小时",[titleArr[i][@"duration"] integerValue]/3600] forState:UIControlStateNormal];
        }
        if (titleArr.count == 1) {
            /*** button常宽不变，改变起始位置 ****/
            btn.frame = CGRectMake(0, 0, kScreenWidth/3, 119*HeightScale);
            btn.lt_centerX = self.lt_centerX;
        }else if (titleArr.count == 2){
            btn.frame = CGRectMake((kScreenWidth-kScreenWidth/1.5-80*WidthScale)/2+(kScreenWidth/3+80*WidthScale)*i, 0, kScreenWidth/3, 119*HeightScale);
        }else if (titleArr.count == 3){
            btn.frame = CGRectMake(0+kScreenWidth/3*i, 0, kScreenWidth/3, 119*HeightScale);
        }
        /*** 添加子控件 ****/
        UILabel *fangLable = [LTControl createLabelWithFrame:CGRectMake(0, 28*HeightScale, kScreenWidth/3, 28*HeightScale) Font:10 Text:@""];
        if (type == 1) {
            fangLable.text = fangArray[i];
        }else{
            fangLable.text = titleArr[i][@"strategy"];
        }
        fangLable.textColor = BlackTextColor;
        fangLable.textAlignment = NSTextAlignmentCenter;
        fangLable.tag = 10+i;
        [btn addSubview:fangLable];
        
        UILabel *quanLabe = [LTControl createLabelWithFrame:CGRectMake(0, fangLable.lt_bottom+60*HeightScale, kScreenWidth/3, 28*HeightScale) Font:10 Text:@""];
        quanLabe.textColor = BlackTextColor;
        quanLabe.textAlignment = NSTextAlignmentCenter;
        quanLabe.tag = 20+i;
        if (type == 1) {
            quanLabe.text = fangArray[i];
        }else{
            quanLabe.text = [NSString stringWithFormat:@"%ld公里 ¥%@元 ",[titleArr[i][@"distance"] integerValue]/1000,titleArr[i][@"tolls"]];
        }
        [btn addSubview:quanLabe];
        [btn.titleLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:18]];
        
        btn.titleLabel.font = [UIFont boldSystemFontOfSize:18];
        if (i == index) {
            btn.selected = YES;
            fangLable.textColor = MainColor;
            quanLabe.textColor = MainColor;
        }
        btn.backgroundColor = [UIColor clearColor];
        btn.tag = 100+i;
        [btn setTitleColor:MainColor forState:UIControlStateSelected];
        [btn setTitleColor:BlackTextColor forState:UIControlStateNormal];
        btn.titleEdgeInsets = UIEdgeInsetsMake(30*HeightScale, 0, 0, 0);
        [self addSubview:btn];
    }
}


- (void)btnCiled:(UIButton *)button{
    UIButton *btn = [self viewWithTag:100+self.index];
    btn.selected = NO;
    
    UILabel *fangLab = [button viewWithTag:button.tag-90];
    UILabel *quanLabe = [button viewWithTag:button.tag-80];
    if (button!= self.selectedBtn) {
        for (int i = 0; i < 3; i ++) {
            UIButton *selectButton = [self viewWithTag:100+i];
            UILabel *fangLab = [selectButton viewWithTag:selectButton.tag-90];
            UILabel *quanLabe = [selectButton viewWithTag:selectButton.tag-80];
            fangLab.textColor = BlackTextColor;
            quanLabe.textColor = BlackTextColor;
        }
        self.selectedBtn.selected = NO;
        button.selected = YES;
        self.selectedBtn = button;
        fangLab.textColor = MainColor;
        quanLabe.textColor = MainColor;
    }else{
        /*** 点击的是按钮本身 ****/
        self.selectedBtn.selected = YES;
        fangLab.textColor = MainColor;
        quanLabe.textColor = MainColor;
    }
    if ([self.delegate respondsToSelector:@selector(projectBtnCiledWithBtn:)]){
        [self.delegate projectBtnCiledWithBtn:button];
    }
}


@end
