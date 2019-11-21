//
//  TextFiledCell.h
//  CXCCF
//
//  Created by 李霆 on 2019/3/13.
//  Copyright © 2019年 CX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DiZhiModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface TextFiledCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *imageBtn;
@property (weak, nonatomic) IBOutlet UIImageView *topImageView;
@property (weak, nonatomic) IBOutlet UIImageView *bottowImageView;
@property (weak, nonatomic) IBOutlet UITextField *textFiled;
@property (weak, nonatomic) IBOutlet UILabel *lineLable;

/*** 位置 ****/
@property(nonatomic)NSInteger ltIndex;
/*** 数组 ****/
@property(nonatomic,copy) NSArray *arr;

- (void)creatArr:(NSArray *)arr andLtIndex:(NSInteger )ltIndex andModel:(DiZhiModel *)model andSouSuo:(BOOL )isSou andAddTu:(BOOL)isAdd;
/*** 删除 ****/
@property(nonatomic,copy) void(^deleteBlock)(DiZhiModel *model);
/*** 显示字段 ****/
@property(nonatomic,strong) DiZhiModel *model;
/*** 回调输入文字和indexpath ****/
@property(nonatomic,copy) void(^backDesAndIndePathBlock)(NSString *textStr, NSInteger selectIndex ,BOOL start,UITextField *selectTextFiled);
/*** 回调开始响应键盘和indexpath ****/
@property(nonatomic,copy) void(^backBeginBlock)(NSString *textStr, NSInteger selectIndex ,BOOL start,UITextField *selectTextFiled);

@end

NS_ASSUME_NONNULL_END
