//
//  ViewController.m
//  rollingNumber
//
//  Created by Owen Chen on 2016/11/24.
//  Copyright © 2016年 conpak. All rights reserved.
//

#import "ViewController.h"
#import "OWRollingNumberView.h"

#define width self.view.frame.size.width
#define height self.view.frame.size.height

@interface ViewController ()

@property (nonatomic, strong) OWRollingNumberView *rollingView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self createRollingNumbersView];
    
    [self createButton];
}

- (void)createRollingNumbersView
{
    _rollingView = [[OWRollingNumberView alloc] initWithFrame:CGRectMake((width - 300.0)/2, (height - 80.0)/2 - 100.0, 300.0, 80.0) number:83546819 labelWidth:25.0 labelGap:10.0];
    _rollingView.backgroundColor = [UIColor blueColor];
    _rollingView.labelColor = [UIColor whiteColor];
    _rollingView.textColor = [UIColor blackColor];
    [self.view addSubview:_rollingView];
}

- (void)createButton
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake((width - 150.0)/2, height - 300.0, 150.0, 50);
    btn.backgroundColor = [UIColor yellowColor];
    [btn setTitle:@"Start Rolling" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(startRolling) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}

- (void)startRolling
{
    [_rollingView startRollWithTimes:5 time:0.3];
}

@end
