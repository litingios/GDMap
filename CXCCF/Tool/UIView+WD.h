/**
 *@项目名称: ETCP停车
 *@文件名称: UIView+WD.h
 *@Copyright: 2015 悦畅科技有限公司. All rights reserved.
 *注意：本内容仅限于悦畅科技有限公司内部传阅，禁止外泄以及用于其他的商业目的
 */

#import <UIKit/UIKit.h>

@interface UIView (WD)
//Set width/height

- (void)setWidth:(CGFloat)width height:(CGFloat)height;

- (void)setWidth:(CGFloat)width;

- (void)setHeight:(CGFloat)height;

- (void)setX:(CGFloat)X;
     
- (void)setY:(CGFloat)Y;

//Add width/height

- (void)addWidth:(CGFloat)widthAdded addHeight:(CGFloat)heightAdded;

- (void)addWidth:(CGFloat)widthAdded;

- (void)addHeight:(CGFloat)heightAdded;

//Set corner radius

- (void)setCornerRadius:(CGFloat)radius;

- (void)setCornerRadius:(CGFloat)radius borderColor:(UIColor *)borderColor;

- (CGRect)frameInWindow;
@end
