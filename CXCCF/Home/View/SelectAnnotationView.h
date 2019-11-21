//
//  SelectAnnotationView.h
//  CXCCF
//
//  Created by 李霆 on 2019/11/19.
//  Copyright © 2019 CX. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SelectAnnotationView : UIView

/*** model ****/
@property(nonatomic,strong) MapModel *model;
/*** <#注释内容#> ****/
@property(nonatomic,copy) void(^deleBlock)(void);


@end

NS_ASSUME_NONNULL_END
