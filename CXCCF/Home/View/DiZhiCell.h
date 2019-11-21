//
//  DiZhiCell.h
//  CXCCF
//
//  Created by 李霆 on 2019/4/11.
//  Copyright © 2019年 CX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DiZhiModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface DiZhiCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *nameLab;
/*** model ****/
@property(nonatomic,strong) DiZhiModel *model;

@end

NS_ASSUME_NONNULL_END
