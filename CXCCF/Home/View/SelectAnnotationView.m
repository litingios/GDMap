//
//  SelectAnnotationView.m
//  CXCCF
//
//  Created by 李霆 on 2019/11/19.
//  Copyright © 2019 CX. All rights reserved.
//

#import "SelectAnnotationView.h"

@interface SelectAnnotationView ()
/*** nameLab ****/
@property(nonatomic,strong) UILabel *nameLab;
@property(nonatomic,strong) UILabel *desLab;


@end

@implementation SelectAnnotationView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self creatUI];
    }
    return self;
}

- (void)creatUI{
    self.nameLab = [[UILabel alloc]initWithFrame:CGRectMake(32*WidthScale, 28*HeightScale, kScreenWidth-100*WidthScale, 50*HeightScale)];
    self.nameLab.textColor = [UIColor blackColor];
    [self.nameLab setFont:[UIFont fontWithName:@"Helvetica-Bold" size:18]];
    self.nameLab.lineBreakMode = NSLineBreakByTruncatingTail;
    [self addSubview:self.nameLab];
    
    self.desLab = [[UILabel alloc]initWithFrame:CGRectMake(32*WidthScale, self.nameLab.lt_bottom+28*HeightScale, kScreenWidth-100*WidthScale, 130*HeightScale)];
    self.desLab.textColor = [UIColor darkGrayColor];
    self.desLab.numberOfLines = 0;
    [self.desLab setFont:[UIFont fontWithName:@"Helvetica-Bold" size:16]];
    self.desLab.lineBreakMode = NSLineBreakByTruncatingTail;
    [self addSubview:self.desLab];
    
    UIButton *deleteBtn = [LTControl createButtonWithFrame:CGRectMake(kScreenWidth-38, 0, 38, 38) ImageName:@"left_delete" Target:self Action:@selector(deleteBtnCiled) Title:@""];
    [deleteBtn setImage:Image(@"left_delete") forState:UIControlStateHighlighted];
    [self addSubview:deleteBtn];
}

- (void)deleteBtnCiled{
    if (self.deleBlock) {
        self.deleBlock();
    }
}

- (void)setModel:(MapModel *)model{
    _model = model;
    self.nameLab.text = model.name;
    self.desLab.text = [NSString stringWithFormat:@"我是第%ld层的大头针，(层数越大，在视图上的位置越靠上，你也会最先发现我哦，优惠的层级属性设的为4，所以就位于最上面了)",model.zIndex];
}

@end
