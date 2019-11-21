//
//  TextFiledCell.m
//  CXCCF
//
//  Created by 李霆 on 2019/3/13.
//  Copyright © 2019年 CX. All rights reserved.
//

#import "TextFiledCell.h"

@interface TextFiledCell ()<UITextFieldDelegate>

/*** 标记终点 ****/
@property(nonatomic,assign) int number;

@property(nonatomic,assign) NSInteger number02;

/*** <#注释内容#> ****/
@property(nonatomic) BOOL isClear;


@end

@implementation TextFiledCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.number = 0;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.textFiled.textColor = BlackTextColor;
    self.textFiled.delegate = self;
    [self.textFiled addTarget:self action:@selector(textFieldChanged:) forControlEvents:UIControlEventEditingChanged];
    self.lineLable.backgroundColor = rgba(222, 223, 224, 1);
}

- (void)creatArr:(NSArray *)arr andLtIndex:(NSInteger )ltIndex andModel:(DiZhiModel *)model andSouSuo:(BOOL )isSou andAddTu:(BOOL)isAdd{
    self.number ++;
    _model = model;
    _ltIndex = ltIndex;
    _arr = arr;
    /*** 针对UI界面的显示问题 ****/
    if (_ltIndex == 0) {
        [self.imageBtn setImage:Image(@"starting_point") forState:UIControlStateNormal];
        self.imageBtn.userInteractionEnabled = NO;
        self.topImageView.hidden = YES;
        self.bottowImageView.hidden = NO;
        self.lineLable.hidden = NO;
    }else if (self.ltIndex == _arr.count - 1){
        [self.imageBtn setImage:Image(@"destination_point") forState:UIControlStateNormal];
        self.imageBtn.userInteractionEnabled = NO;
        self.topImageView.hidden = NO;
        self.bottowImageView.hidden = YES;
        self.lineLable.hidden = YES;
    }else{
        [self.imageBtn setImage:Image(@"luxian_delect") forState:UIControlStateNormal];
        self.imageBtn.userInteractionEnabled = YES;
        self.topImageView.hidden = NO;
        self.bottowImageView.hidden = NO;
        self.lineLable.hidden = NO;
    }
    /*** 针对textFiled赋值问题 ****/
    if ([model.name rangeOfString:@"输入"].location != NSNotFound) {
        if (isSou == NO) {
            self.textFiled.text = @"";
        }
        self.textFiled.placeholder = model.name;
    }else{
        self.textFiled.textColor = BlackTextColor;
        self.textFiled.placeholder = @"请输入起点";
        self.textFiled.text = model.name;
    }
    
    /*** 针对键盘的响应问题 ****/
    if (isSou == YES) {
        if ([model.name rangeOfString:@"输入"].location != NSNotFound && self.textFiled.text.length != 0) {
            [self.textFiled becomeFirstResponder];
        }
    }else{
        if (arr.count == 2) {
            if (_ltIndex == 1) {
                if (self.number > 1) {
                    if ([model.name rangeOfString:@"输入"].location != NSNotFound) {
                        [self.textFiled becomeFirstResponder];
                    }
                }
            }
        }else if (arr.count > 2){
            if (isAdd == YES) {
                if (_ltIndex == arr.count - 2) {
                    if ([model.name rangeOfString:@"输入"].location != NSNotFound) {
                        self.textFiled.text = @"";
                        [self.textFiled becomeFirstResponder];
                    }
                }
            }else{
//                if ([model.name rangeOfString:@"输入"].location != NSNotFound) {
//                    if (_ltIndex == [[[NSUserDefaults standardUserDefaults] objectForKey:@"number02"]integerValue]+1) {
//                        [self.textFiled becomeFirstResponder];
//                    }
//                }
            }
        }
    }
    
    if (self.isClear == YES) {
        if (_ltIndex == [arr indexOfObject:model]) {
            if ([model.name rangeOfString:@"输入"].location != NSNotFound) {
//                self.textFiled.text = @"";
                [self.textFiled becomeFirstResponder];
                self.isClear = NO;
            }
        }
    }
}

- (IBAction)deledateBtnCiled:(id)sender {
    if (self.deleteBlock) {
        self.textFiled.text = nil;
        self.deleteBlock(_model);
    }
}

/*** 回调输入文字 ****/
- (void)textFieldChanged:(UITextField*)textField{
    NSString *searchStr = textField.text;
    if (searchStr.length == 0) {
        [textField becomeFirstResponder];
        self.isClear = YES;
    }
    
    if (self.backDesAndIndePathBlock) {
//        self.number02 = _ltIndex;
//        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"number02"];
//        [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%ld",self.number02] forKey:@"number02"];
        self.backDesAndIndePathBlock(searchStr, _ltIndex,NO,self.textFiled);
    }
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    //点击UITextField，全选文字
    UITextPosition *endDocument = textField.endOfDocument;//获取 text的 尾部的 TextPositext
    UITextPosition *end = [textField positionFromPosition:endDocument offset:0];
    UITextPosition *start = [textField positionFromPosition:end offset:-textField.text.length];//左－右＋
    textField.selectedTextRange = [textField textRangeFromPosition:start toPosition:end];
    if (self.backBeginBlock) {
        self.backBeginBlock(textField.text, _ltIndex,YES,self.textFiled);
    }
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    //点击UITextField，全选文字
    UITextPosition *beginDocument = textField.beginningOfDocument;
    UITextPosition *end = [textField positionFromPosition:beginDocument offset:0];
    UITextPosition *start = [textField positionFromPosition:beginDocument offset:0];//左－右＋
    textField.selectedTextRange = [textField textRangeFromPosition:start toPosition:end];
    return YES;
}


@end
