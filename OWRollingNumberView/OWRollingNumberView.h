//
//  OWRollingView.h
//  rollingNumber
//
//  Created by Owen Chen on 2016/11/24.
//  Copyright © 2016年 conpak. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RollingLabelView : UIView

@property (nonatomic, strong) UIColor *textColor;

- (instancetype)initWithFrame:(CGRect)frame NumString:(NSString *)numString labelWidth:(CGFloat)labWidth;
- (void)startRollWithTimes:(NSInteger)times time:(CGFloat)time;

@end

@interface OWRollingNumberView : UIView

@property (nonatomic, strong) UIColor *labelColor;
@property (nonatomic, strong) UIColor *textColor;

- (instancetype)initWithFrame:(CGRect)frame number:(NSInteger)num labelWidth:(CGFloat)LabWidth labelGap:(CGFloat)gap;
- (void)startRollWithTimes:(NSInteger)times time:(CGFloat)time;

@end
