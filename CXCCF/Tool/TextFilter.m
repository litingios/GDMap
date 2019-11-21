//
//  TextFilter.m
//
//  Created by yangqi on 13-12-2.
//  Copyright (c) 2013年 yangqi. All rights reserved.
//

#import "TextFilter.h"
#define LEN_AFTER_POINT (2)

@implementation TextFilter
@synthesize textFilterDelegate = _textFilterDelegate;
@synthesize MaxLen;
@synthesize AllowNum;
@synthesize AllowCH;
@synthesize AllowLetter;
@synthesize AllowLETTER;
@synthesize AllowSymbol;
@synthesize OtherString;

- (void)dealloc
{
#if __has_feature(objc_arc)
#else
    textFilterDelegate = nil;
#endif
    [self setOtherString:nil];
}

//==============================================================================
- (void)SetFilter:(UITextField *)textField
         delegate:(id<TextFilterDelegate>)delegate
           maxLen:(int)maxLen
         allowNum:(BOOL)allowNum
          allowCH:(BOOL)allowCH
      allowLetter:(BOOL)allowLetter
      allowLETTER:(BOOL)allowLETTER
      allowSymbol:(BOOL)allowSymbol
      allowOthers:(NSString *)otherString
{
    textField.delegate = self;
    self.textFilterDelegate = delegate;
    self.MaxLen = maxLen;
    m_count_CH_len = NO;
    self.AllowNum = allowNum;
    self.AllowCH = allowCH;
    self.AllowNum = allowNum;
    self.AllowLetter = allowLetter;
    self.AllowLETTER = allowLETTER;
    self.AllowSymbol = allowSymbol;
    [self setOtherString:nil];
    if(otherString == nil)
    {
        otherString = @"";
    }
    self.OtherString = [[NSString alloc] initWithString:otherString];
}



//==============================================================================
//maxCHLen:最大输入长度，中文算2个字符
- (void)SetFilter:(UITextField *)textField
         delegate:(id<TextFilterDelegate>)delegate
           maxCHLen:(int)maxLen
         allowNum:(BOOL)allowNum
          allowCH:(BOOL)allowCH
      allowLetter:(BOOL)allowLetter
      allowLETTER:(BOOL)allowLETTER
      allowSymbol:(BOOL)allowSymbol
      allowOthers:(NSString *)otherString
{
    textField.delegate = self;
    self.textFilterDelegate = delegate;
    self.MaxLen = maxLen;
    m_count_CH_len = YES;
    self.AllowNum = allowNum;
    self.AllowCH = allowCH;
    self.AllowNum = allowNum;
    self.AllowLetter = allowLetter;
    self.AllowLETTER = allowLETTER;
    self.AllowSymbol = allowSymbol;
    [self setOtherString:nil];
    if(otherString == nil)
    {
        otherString = @"";
    }
    self.OtherString = [[NSString alloc] initWithString:otherString];
}



//==============================================================================
- (void)SetMoneyFilter:(UITextField *)textField delegate:(id<TextFilterDelegate>)delegate
{
    m_money_mode = YES;
    textField.delegate = self;
    self.textFilterDelegate = delegate;
}




//==============================================================================
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if([self.textFilterDelegate respondsToSelector:@selector(textFieldShouldBeginEditing:)])
    {
        return [self.textFilterDelegate textFieldShouldBeginEditing:textField];
    }
    else
    {
        return YES;
    }
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if([self.textFilterDelegate respondsToSelector:@selector(textFieldDidBeginEditing:)])
    {
        [self.textFilterDelegate textFieldShouldBeginEditing:textField];
    }
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    if([self.textFilterDelegate respondsToSelector:@selector(textFieldShouldEndEditing:)])
    {
        
        return [self.textFilterDelegate textFieldShouldEndEditing:textField];
    }
    else
    {
        return YES;
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if([self.textFilterDelegate respondsToSelector:@selector(textFieldDidEndEditing:)])
    {
        [self.textFilterDelegate textFieldDidEndEditing:textField];
    }
}

- (BOOL)textField:(UITextField *)textField
shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    BOOL ret = YES;
    int strLength;
    if(m_count_CH_len)
    {
        NSString *str = [textField.text stringByReplacingCharactersInRange:range
                                                                withString:string];
        strLength = [self lengthWithCH:str];
    }
    else
    {
        strLength = [textField.text length] - range.length + [string length];
    }
    
    if(m_money_mode)
    {
        NSString *final_str =
        [textField.text stringByReplacingCharactersInRange:range
                                                withString:string];
        for (int i=final_str.length-1; i>=0; i--)
        {
            NSCharacterSet *strSet =
             [NSCharacterSet characterSetWithCharactersInString:@"0123456789.-"];
            char ch = [final_str characterAtIndex:i];
            ret = [strSet characterIsMember:ch];
            if(ret == YES)
            {
                if(ch == '-' && [final_str rangeOfString:@"-"].location > 0)
                {
                    ret = NO;
                }
                int pos = [final_str rangeOfString:@"."].location;
                if(pos < 0 || pos > strLength)
                {
                    ret = YES;
                    break;
                }
                if(final_str.length - pos > (LEN_AFTER_POINT+1))
                {
                    ret = NO;
                }
            }
            else
            {
                break;
            }
        }
        return ret;
    }
    
    if(strLength > self.MaxLen)
    {
        if([self.textFilterDelegate respondsToSelector:
            @selector(textField:shouldChangeCharactersInRange:replacementString:)])
        {
            [self.textFilterDelegate textField:textField
                 shouldChangeCharactersInRange:range
                             replacementString:string];
        }
        return NO;
    }
    
    for(NSInteger i =0; i< [string length]; i++)
    {
        unichar ch = [string characterAtIndex:i];
        if('0' <= ch && ch <= '9')
        {
            ret = self.AllowNum;
            if(self.AllowNum)
            {
                continue;
            }
        }
        if('a' <= ch && ch <= 'z')
        {
            ret = self.AllowLetter;
            if(self.AllowLetter)
            {
                continue;
            }
        }
        if('A' <= ch && ch <= 'Z')
        {
            ret = self.AllowLETTER;
            if(self.AllowLETTER)
            {
                continue;
            }
        }
        if(0x4e00 <= ch && ch <= 0x9fff)
        {
            ret = self.AllowCH;
            if(self.AllowCH)
            {
                continue;
            }
        }
        
        if(self.OtherString != nil && ![self.OtherString isEqualToString:@""])
        {
            NSCharacterSet *strSet = 
             [NSCharacterSet characterSetWithCharactersInString:self.OtherString];
            ret = [strSet characterIsMember:ch];
            if(ret)
            {
                continue;
            }
        }
        
        if(!( (0x4e00 <= ch && ch<= 0x9fff) ||
              ('a'    <= ch && ch<=    'z') ||
              ('A'    <= ch && ch<=    'Z') ||
              ('0'    <= ch && ch<=    '9')
           ))
        {
            ret = self.AllowSymbol;
            if(self.AllowSymbol)
            {
                continue;
            }
        }
    }
    
    if([self.textFilterDelegate respondsToSelector:
        @selector(textField:shouldChangeCharactersInRange:replacementString:)])
    {
        [self.textFilterDelegate textField:textField
        shouldChangeCharactersInRange:range
                    replacementString:string];
    }
    
    return ret;
}

- (BOOL)textFieldShouldClear:(UITextField *)textField
{
    if([self.textFilterDelegate respondsToSelector:@selector(textFieldShouldClear:)])
    {
        
        return [self.textFilterDelegate textFieldShouldClear:textField];
    }
    else
    {
        return YES;
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if([self.textFilterDelegate respondsToSelector:@selector(textFieldShouldReturn:)])
    {
        return [self.textFilterDelegate textFieldShouldReturn:textField];
    }
    else
    {
        return YES;
    }
}




//==============================================================================
-  (int)lengthWithCH:(NSString *)strtemp
{
    
    int strlength = 0;
    char *p = (char *)[strtemp cStringUsingEncoding:NSUnicodeStringEncoding];
    int len = [strtemp lengthOfBytesUsingEncoding:NSUnicodeStringEncoding];
    for (int i=0; i<len; i++)
    {
        if (*p)
        {
            p++;
            strlength++;
        }
        else
        {
            p++;
        }
    }
    return strlength;
}
@end
