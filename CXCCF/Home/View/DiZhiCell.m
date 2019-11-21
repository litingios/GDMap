//
//  DiZhiCell.m
//  CXCCF
//
//  Created by 李霆 on 2019/4/11.
//  Copyright © 2019年 CX. All rights reserved.
//

#import "DiZhiCell.h"

@implementation DiZhiCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.nameLab.textColor = BlackTextColor;
}

- (void)setModel:(DiZhiModel *)model{
    _model = model;
    self.nameLab.text = model.name;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
