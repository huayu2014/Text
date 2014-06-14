//
//  MainViewController.m
//  Test
//
//  Created by chenzhenhua on 14-5-14.
//  Copyright (c) 2014年 chenzhenhua. All rights reserved.
//

#import "MainViewController.h"
#import "SubViewController.h"
#import "YRUISignal.h"
#import "DropDownViewController.h"
@interface MainViewController ()
{
    UITextField *_tf;
}
@end

@implementation MainViewController
@dynamic yearArray,monthArray;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //self.view.backgroundColor=[UIColor purpleColor];
    _tf=[[UITextField alloc]initWithFrame:CGRectMake(100, 200, 500, 60)];
    _tf.borderStyle=UITextBorderStyleRoundedRect;
    _tf.font=[UIFont boldSystemFontOfSize:24];
    [self.view addSubview:_tf];
    
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    btn.frame=CGRectMake(100, 300, 500, 60);
    btn.tag=100;
    [btn setTitle:@"确 定" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    btn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    btn.frame=CGRectMake(100, 400, 500, 60);
    btn.tag=120;
    [btn setTitle:@"跳 转" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    yearBrn =[UIButton buttonWithType:UIButtonTypeCustom];
    yearBrn.frame=CGRectMake(100, 500,180, 60);
    [yearBrn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [yearBrn addTarget:self action:@selector(yearBrnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:yearBrn];
    
    yearArray=[[NSArray alloc]initWithArray:[NSArray arrayWithObjects:@"北京",@"天津",@"上海",@"南京",@"重庆",@"广州",@"深圳",@"东北",@"西安",@"黑龙江", nil]];
    yearPressView=[[DropDownViewController alloc]initWithArrayData:yearArray cellHeight:30 heightTableView:250 paddingTop:-5 paddingLeft:-5 paddingRight:-10 refView:yearBrn animation:BLENDIN openAnimationDuration:2 closeAnimationDuration:2];
    yearPressView.delegate=self;
    [self.view addSubview:yearPressView.view];
    [yearBrn setTitle:[yearArray objectAtIndex:0] forState:UIControlStateNormal];
    
    monthBrn=[UIButton buttonWithType:UIButtonTypeCustom];
    monthBrn.frame=CGRectMake(400, 500,180, 60);
    [monthBrn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [monthBrn addTarget:self action:@selector(monthBrnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:monthBrn];
    
    monthArray=[[NSArray alloc]initWithArray:[NSArray arrayWithObjects:@"01",@"02",@"03",@"04",@"05",@"06",@"07",@"08",@"09",@"10",@"11",@"12", nil]];
    monthPressView=[[DropDownViewController alloc]initWithArrayData:monthArray cellHeight:30 heightTableView:250 paddingTop:-5 paddingLeft:-5 paddingRight:-10 refView:monthBrn animation:BLENDIN openAnimationDuration:2 closeAnimationDuration:2];
    monthPressView.delegate=self;
    [self.view addSubview:monthPressView.view];
    [monthBrn setTitle:[monthArray objectAtIndex:0] forState:UIControlStateNormal];
    
}
//第三方选中下拉菜单
-(void)dropDownCellSelected:(NSInteger)returnIndex
{
    [yearBrn setTitle:[yearArray objectAtIndex:returnIndex] forState:UIControlStateNormal];
    index=returnIndex;
}
//开启下拉菜单动画
-(void)yearBrnClick
{
    [yearPressView openAnimation];
}

-(void)dropDown:(NSInteger)indexRow
{
    [monthBrn setTitle:[monthArray objectAtIndex:indexRow] forState:UIControlStateNormal];
    number=indexRow;
}
-(void)monthBrnClick
{
    [monthPressView openAnimation];
}
#pragma mark - 身份证识别
-(BOOL)checkIdentityCardNo:(NSString*)cardNo
{
    if (cardNo.length != 18) {
        return  NO;
    }
    NSArray* codeArray = [NSArray arrayWithObjects:@"7",@"9",@"10",@"5",@"8",@"4",@"2",@"1",@"6",@"3",@"7",@"9",@"10",@"5",@"8",@"4",@"2", nil];
    NSDictionary* checkCodeDic = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:@"1",@"0",@"X",@"9",@"8",@"7",@"6",@"5",@"4",@"3",@"2", nil]  forKeys:[NSArray arrayWithObjects:@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10", nil]];
    
    NSScanner* scan = [NSScanner scannerWithString:[cardNo substringToIndex:17]];
    
    int val;
    BOOL isNum = [scan scanInt:&val] && [scan isAtEnd];
    if (!isNum) {
        return NO;
    }
    int sumValue = 0;
    
    for (int i =0; i<17; i++) {
        sumValue+=[[cardNo substringWithRange:NSMakeRange(i , 1) ] intValue]* [[codeArray objectAtIndex:i] intValue];
    }
    
    NSString* strlast = [checkCodeDic objectForKey:[NSString stringWithFormat:@"%d",sumValue%11]];
    
    if ([strlast isEqualToString: [[cardNo substringWithRange:NSMakeRange(17, 1)]uppercaseString]]) {
        return YES;
    }
    return  NO;
}
-(void)btnClick:(UIButton *)sender
{
    if(sender.tag==100){
        if (_tf.text.length == 15 || _tf.text.length == 18) {
            NSString *emailRegex = @"^[0-9|x]*$";
            NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
            bool sfzNo = [emailTest evaluateWithObject:[_tf.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]];
            
            if (_tf.text.length == 15) {
                if (!sfzNo) {
                    UIAlertView *alter=[[UIAlertView alloc]initWithTitle:@"" message:@"请输入正确的身份证号!" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
                    [alter show];
                    return;
                }
            }
            else if (_tf.text.length == 18) {
                bool sfz18NO = [self checkIdentityCardNo:_tf.text];
                if (!sfz18NO) {
                    UIAlertView *alter=[[UIAlertView alloc]initWithTitle:@"" message:@"请输入正确的身份证号!" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
                    [alter show];
                    return;
                }
            }
        }else{
            UIAlertView *alter=[[UIAlertView alloc]initWithTitle:@"" message:@"请输入正确的身份证号!" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [alter show];
            return;
        }
    }else{
//        SubViewController *svc=[[SubViewController alloc]init];
//        [self.navigationController pushViewController:svc animated:YES];
        mUIView=[[UIView1 alloc]initWithFrame:self.view.bounds];
        [self.view.window addSubview:mUIView];
    }
}
-(BOOL)handleYRUISignal:(YRUISignal *)signal{
    if ([signal.name isEqualToString:@"返回View"]) {
        NSLog(@"TestViewLevel1 find the event ,but do nothing!");
        [mUIView removeFromSuperview];
        return true;//根据需要中断响应链
    }
    return false;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
