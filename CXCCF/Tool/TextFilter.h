//
//  TextFilter.h
//
//  Created by yangqi on 13-12-2.
//  Copyright (c) 2013年 yangqi. All rights reserved.
//  一个可以为UITextField设置输入限制的类

#import <Foundation/Foundation.h>

#if __has_feature(objc_arc)
#define PROPERTY_WEAK weak
#else
#define PROPERTY_WEAK assign
#endif

//使用TextFilter设置输入限制后，将无法再使用UITextFieldDelegate捕捉输入事件；
//这时可以使用TextFilterDelegate。
@protocol TextFilterDelegate <NSObject>
@optional
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField;        // return NO to disallow editing.
- (void)textFieldDidBeginEditing:(UITextField *)textField;           // became first responder
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField;          // return YES to allow editing to stop and to resign first responder status. NO to disallow the editing session to end
- (void)textFieldDidEndEditing:(UITextField *)textField;             // may be called if forced even if shouldEndEditing returns NO (e.g. view removed from window) or endEditing:YES called

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string;   // return NO to not change text

- (BOOL)textFieldShouldClear:(UITextField *)textField;               // called when clear button pressed. return NO to ignore (no notifications)
- (BOOL)textFieldShouldReturn:(UITextField *)textField;              // called when 'return' key pressed. return NO to ignore.
@end






@interface TextFilter : NSObject<UITextFieldDelegate>
{
    id<TextFilterDelegate> textFilterDelegate;
    int  MaxLen;
    BOOL AllowNum;
    BOOL AllowCH;
    BOOL AllowLetter;
    BOOL AllowLETTER;
    BOOL AllowSymbol;
    NSString *OtherString;
    
    BOOL m_money_mode; //置为YES时为判断金额的模式
    BOOL m_count_CH_len; //置为YES时将中文统计为2个字符，否则为一个
}
@property (PROPERTY_WEAK, nonatomic) id<TextFilterDelegate> textFilterDelegate;
@property (assign, nonatomic) int  MaxLen;
@property (assign, nonatomic) BOOL AllowNum;
@property (assign, nonatomic) BOOL AllowCH;
@property (assign, nonatomic) BOOL AllowLetter;
@property (assign, nonatomic) BOOL AllowLETTER;
@property (assign, nonatomic) BOOL AllowSymbol;
@property (strong, nonatomic) NSString *OtherString;

//为一个UITextField设置输入限制。
- (void)SetFilter:(UITextField *)textField
         delegate:(id<TextFilterDelegate>)delegate
           maxLen:(int)maxLen
         allowNum:(BOOL)allowNum
          allowCH:(BOOL)allowCH
      allowLetter:(BOOL)allowLetter
      allowLETTER:(BOOL)allowLETTER
      allowSymbol:(BOOL)allowSymbol
      allowOthers:(NSString *)otherString;

//maxCHLen:最大输入长度，中文算2个字符
- (void)SetFilter:(UITextField *)textField
         delegate:(id<TextFilterDelegate>)delegate
         maxCHLen:(int)maxLen
         allowNum:(BOOL)allowNum
          allowCH:(BOOL)allowCH
      allowLetter:(BOOL)allowLetter
      allowLETTER:(BOOL)allowLETTER
      allowSymbol:(BOOL)allowSymbol
      allowOthers:(NSString *)otherString;

//对于一个想作为金额输入的UITextField，使用这个方法。
- (void)SetMoneyFilter:(UITextField *)textField
              delegate:(id<TextFilterDelegate>)delegate;

@end

@interface TextFilter()
-  (int)lengthWithCH:(NSString *)strtemp;
@end
