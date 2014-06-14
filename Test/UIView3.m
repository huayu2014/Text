//
//  UIView3.m
//  Test
//
//  Created by chenzhenhua on 14-5-23.
//  Copyright (c) 2014年 chenzhenhua. All rights reserved.
//

#import "UIView3.h"
#import "YRUISignal.h"
@implementation UIView3

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self createView];
    }
    return self;
}
-(void)createView
{
//    UIView *mView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 768, 1024)];
//    mView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.7f];
//    [self addSubview:mView];
    
    UIView *View1=[[UIView alloc]initWithFrame:CGRectMake(114,150,540,600)];
    View1.backgroundColor=[UIColor yellowColor];
    [self addSubview:View1];
    
    UILabel *label1=[[UILabel alloc]initWithFrame:CGRectMake(10, 50, 500, 60)];
    label1.text=@"我是第三个View哦";
    [View1 addSubview:label1];
    
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    btn.frame=CGRectMake(10, 200, 500, 60);
    [btn setTitle:@"点击跳转到第一个View里面。。。" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnClcik) forControlEvents:UIControlEventTouchUpInside];
    [View1 addSubview:btn];
}
-(void)btnClcik{
    [self sendYRUISignalForKey:@"返回View"];
}

@end
