//
//  MainViewController.h
//  Test
//
//  Created by chenzhenhua on 14-5-14.
//  Copyright (c) 2014年 chenzhenhua. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView1.h"
#import "DropDownViewController.h"
@interface MainViewController : UIViewController<UITextFieldDelegate,DropDownViewControllerDelegate,UITextViewDelegate>
{
    UIView1 *mUIView;
    UIButton *yearBrn;
    UIButton *monthBrn;
    DropDownViewController *yearPressView;
    DropDownViewController *monthPressView;
    NSInteger index;
    NSInteger number;
    NSArray *yearArray;
    NSArray *monthArray;
}
@property(nonatomic,retain)NSArray *yearArray;
@property(nonatomic,retain)NSArray *monthArray;
@property(nonatomic,assign)NSInteger index;
@end
