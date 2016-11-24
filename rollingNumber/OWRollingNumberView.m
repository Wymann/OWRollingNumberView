//
//  OWRollingView.m
//  rollingNumber
//
//  Created by Owen Chen on 2016/11/24.
//  Copyright © 2016年 conpak. All rights reserved.
//

#import "OWRollingNumberView.h"

#define width self.frame.size.width
#define height self.frame.size.height

#define labelFont [UIFont systemFontOfSize:15.0]

@interface RollingLabelView()

@property (nonatomic, strong) NSString *numString;
@property (nonatomic, strong) UILabel *label;

@end

@implementation RollingLabelView
{
    CGFloat labelWidth;
    BOOL rolling;
    NSInteger currentTimes;
}

- (instancetype)initWithFrame:(CGRect)frame NumString:(NSString *)numString labelWidth:(CGFloat)labWidth
{
    self = [super initWithFrame:frame];
    if (self) {
        _numString = numString;
        labelWidth = labWidth;
        [self setUI];
    }
    return self;
}

- (void)setUI
{
    rolling = YES;
    currentTimes = 1;
    
    self.backgroundColor = [UIColor whiteColor];
    self.clipsToBounds = YES;
    
    _label = [[UILabel alloc] initWithFrame:CGRectMake(0, -labelWidth, labelWidth, labelWidth)];
    _label.textAlignment = NSTextAlignmentCenter;
    _label.font = labelFont;
    [self addSubview:_label];
}

-(void)setTextColor:(UIColor *)textColor
{
    _textColor = textColor;
    _label.textColor = _textColor;
}

- (void)startRollWithTimes:(NSInteger)times time:(CGFloat)time
{
    if ((currentTimes - 1) != times) {
        
        if (currentTimes != 1 || [_label.text isEqualToString:@""]) {
            int randomNum = arc4random() % 10;
            _label.text = [NSString stringWithFormat:@"%d",randomNum];
        }
        
        [UIView animateWithDuration:time animations:^{
            if (currentTimes == times) {
                CGRect rect = _label.frame;
                rect.origin.y = 0;
                _label.frame = rect;
                _label.text = _numString;
            }else{
                CGRect rect = _label.frame;
                rect.origin.y = labelWidth;
                _label.frame = rect;
            }
        } completion:^(BOOL finished) {
            if (currentTimes != times) {
                CGRect rect = _label.frame;
                rect.origin.y = -labelWidth;
                _label.frame = rect;
            }
            currentTimes += 1;
            [self startRollWithTimes:times time:time];
        }];
    }else{
        currentTimes = 1;
    }
}

@end

@interface OWRollingNumberView()

@property (nonatomic) NSInteger num;
@property (nonatomic, strong) NSMutableArray *numArray;

@end

@implementation OWRollingNumberView
{
    CGFloat labelWidth;
    CGFloat labelGap;
}

- (instancetype)initWithFrame:(CGRect)frame number:(NSInteger)num labelWidth:(CGFloat)LabWidth labelGap:(CGFloat)gap
{
    self = [super initWithFrame:frame];
    if (self) {
        _num = num;
        labelWidth = LabWidth;
        labelGap = gap;
        [self setNumArray];
        [self setUI];
    }
    return self;
}

#pragma mark - set NumArray
- (void)setNumArray
{
    _numArray = [NSMutableArray array];
    
    NSMutableString *numStr = [NSMutableString stringWithFormat:@"%ld",_num];
    for (NSInteger i = 0; i < numStr.length; i++) {
        NSRange range = NSMakeRange(i, 1);
        NSString *str = [numStr substringWithRange:range];
        [_numArray addObject:str];
    }
}

#pragma mark - setUI
- (void)setUI
{
    if (_numArray.count * labelWidth + (_numArray.count - 1) * labelGap > width) {
        NSLog(@"warn: labels are out of scope");
    }
    
    CGFloat beginX = (width - _numArray.count * labelWidth - (_numArray.count - 1) * labelGap)/2;
    CGFloat Y = (height - labelWidth)/2;
    
    for (NSInteger i = 0; i < _numArray.count; i++) {
        CGFloat X = i * (labelGap + labelWidth) + beginX;
        CGRect frame = CGRectMake(X, Y, labelWidth, labelWidth);
        RollingLabelView *rollingLabelView = [[RollingLabelView alloc] initWithFrame:frame NumString:_numArray[i] labelWidth:labelWidth];
        [self addSubview:rollingLabelView];
    }
}

-(void)setLabelColor:(UIColor *)labelColor
{
    _labelColor = labelColor;
    for (RollingLabelView *labelView in self.subviews) {
        labelView.backgroundColor = _labelColor;
    }
}

-(void)setTextColor:(UIColor *)textColor
{
    _textColor = textColor;
    for (RollingLabelView *labelView in self.subviews) {
        labelView.textColor = _textColor;
    }
}

#pragma mark - start roll
- (void)startRollWithTimes:(NSInteger)times time:(CGFloat)time
{
    for (RollingLabelView *labelView in self.subviews) {
        [labelView startRollWithTimes:times time:time];
    }
}

@end
