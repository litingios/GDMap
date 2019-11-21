/**
 *@项目名称: ETCP停车
 *@文件名称: UIView+WD.m
 *@Copyright: 2015 悦畅科技有限公司. All rights reserved.
 *注意：本内容仅限于悦畅科技有限公司内部传阅，禁止外泄以及用于其他的商业目的
 */

#import "UIView+WD.h"
@implementation UIView (WD)
- (void)setWidth:(CGFloat)width height:(CGFloat)height
{
    CGRect origionRect = self.frame;
    CGRect newRect = CGRectMake(origionRect.origin.x, origionRect.origin.y, width, height);
    self.frame = newRect;
}

- (void)setWidth:(CGFloat)width
{
    CGRect origionRect = self.frame;
    CGRect newRect = CGRectMake(origionRect.origin.x, origionRect.origin.y, width, origionRect.size.height);
    self.frame = newRect;
}

- (void)setHeight:(CGFloat)height
{
    CGRect origionRect = self.frame;
    CGRect newRect = CGRectMake(origionRect.origin.x, origionRect.origin.y, origionRect.size.width, height);
    self.frame = newRect;
}

- (void)setX:(CGFloat)X;
{
    CGRect origionRect = self.frame;
    CGRect newRect = CGRectMake(X, origionRect.origin.y, origionRect.size.width, origionRect.size.height);
    self.frame = newRect;
    
}

- (void)setY:(CGFloat)Y;{
    CGRect origionRect = self.frame;
    CGRect newRect = CGRectMake(origionRect.origin.x, Y, origionRect.size.width, origionRect.size.height);
    self.frame = newRect;
}

- (void)addWidth:(CGFloat)widthAdded addHeight:(CGFloat)heightAdded
{
    CGRect originRect = self.frame;
    CGFloat newWidth = originRect.size.width + widthAdded;
    CGFloat newHeight = originRect.size.height + heightAdded;
    CGRect newRect = CGRectMake(originRect.origin.x, originRect.origin.y, newWidth, newHeight);
    self.frame = newRect;
}

- (void)addWidth:(CGFloat)widthAdded
{
    [self addWidth:widthAdded addHeight:0];
}

- (void)addHeight:(CGFloat)heightAdded
{
    [self addWidth:0 addHeight:heightAdded];
}

- (void)setCornerRadius:(CGFloat)radius
{
    [self setCornerRadius:radius borderColor:nil];
}

- (void)setCornerRadius:(CGFloat)radius borderColor:(UIColor *)borderColor
{
//    [self.layer setBackgroundColor:[[UIColor whiteColor] CGColor]];
    [self.layer setBorderColor:[borderColor CGColor]];
    [self.layer setBorderWidth:.5];
    [self.layer setCornerRadius:radius];
    [self.layer setMasksToBounds:YES];
    self.clipsToBounds = YES;
}

- (CGRect)frameInWindow
{
    CGRect frameInWindow = [self.superview convertRect:self.frame
                                                toView:self.window];
    return frameInWindow;
}

@end

