//
//  UIView1.m
//  Test
//
//  Created by chenzhenhua on 14-5-23.
//  Copyright (c) 2014年 chenzhenhua. All rights reserved.
//

#import "UIView1.h"
#import "YRUISignal.h"
@implementation UIView1

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
    UIView *mView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 768, 1024)];
    mView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.7f];
    [self addSubview:mView];
    
    UIView *View1=[[UIView alloc]initWithFrame:CGRectMake(114,150,540,600)];
    View1.backgroundColor=[UIColor redColor];
    [mView addSubview:View1];

    UILabel *label1=[[UILabel alloc]initWithFrame:CGRectMake(10, 50, 500, 60)];
    label1.text=@"我是第一个View哦";
    [View1 addSubview:label1];
    
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    btn.frame=CGRectMake(10, 200, 500, 60);
    [btn setTitle:@"点击跳转到第二个View里面。。。" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnClcik) forControlEvents:UIControlEventTouchUpInside];
    [View1 addSubview:btn];
}
-(void)btnClcik
{
    mUIView2 =[[UIView2 alloc]initWithFrame:self.bounds];
    [self addSubview:mUIView2];
}
-(BOOL)handleYRUISignal:(YRUISignal *)signal{
    if ([signal.name isEqualToString:@"返回View"]) {
        NSLog(@"TestViewLevel1 find the event ,but do nothing!");
        [mUIView2 removeFromSuperview];
        [self removeFromSuperview];
        return false;//根据需要中断响应链
    }
    return false;
}
@end
