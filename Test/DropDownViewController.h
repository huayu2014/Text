//
//  DropDownViewController.h
//  TrafficQuery
//
//  Created by qianfeng on 13-6-18.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
  BLENDIN, 
    GROW,
    BOTH
}AnimationType;

@protocol DropDownViewControllerDelegate <NSObject>

@required
-(void)dropDownCellSelected:(NSInteger)returnIndex;
-(void)dropDown:(NSInteger)indexRow;
@end
@interface DropDownViewController : UIViewController
<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *uitableView;
    
    NSArray *arrayData;
    
    CGFloat heightOfCell;
    
    CGFloat paddingLeft;
    
    CGFloat paddingRight;
    
    CGFloat paddingTop;
    
    CGFloat heightTableView;
    
    UIView *refView;
    
    id<DropDownViewControllerDelegate>delegate;
    
    NSInteger animationType;
    
    CGFloat open;
    
    CGFloat close;   
}
@property(nonatomic,assign)id<DropDownViewControllerDelegate>delegate;

@property(nonatomic,retain)UITableView *uitableView;

@property(nonatomic,retain)NSArray *arrayData;

@property (nonatomic) CGFloat heightOfCell;

@property (nonatomic) CGFloat paddingLeft;

@property (nonatomic) CGFloat paddingRight;

@property (nonatomic) CGFloat paddingTop;

@property (nonatomic) CGFloat heightTableView;

@property (nonatomic,retain)UIView *refView;

@property (nonatomic) CGFloat open;

@property (nonatomic) CGFloat close;
-(id)initWithArrayData:(NSArray *)data cellHeight:(CGFloat)cHeight heightTableView:(CGFloat)tHeightTableView paddingTop:(CGFloat)tPaddingTop paddingLeft:(CGFloat)tPaddingLeft paddingRight:(CGFloat)tPaddingRight refView:(UIView*)rView animation:(AnimationType)tAnimation  openAnimationDuration:(CGFloat)openDuration closeAnimationDuration:(CGFloat)closeDuration;

-(void)closeAnimation;

-(void)openAnimation;

-(void)hideView;

@end
