//
//  DropDownViewController.m
//  TrafficQuery
//
//  Created by qianfeng on 13-6-18.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import "DropDownViewController.h"
#import "QuartzCore/QuartzCore.h"
@implementation DropDownViewController
@synthesize uitableView;
@synthesize arrayData,heightOfCell,refView;
@synthesize paddingTop,paddingRight,paddingLeft;
@synthesize open,close;
@synthesize heightTableView;
@synthesize delegate;
-(void)dealloc
{
    [super dealloc];
    [uitableView release];
    [arrayData release];
    [refView release];

}
-(id)initWithArrayData:(NSArray *)data cellHeight:(CGFloat)cHeight heightTableView:(CGFloat)tHeightTableView paddingTop:(CGFloat)tPaddingTop paddingLeft:(CGFloat)tPaddingLeft paddingRight:(CGFloat)tPaddingRight refView:(UIView *)rView animation:(AnimationType)tAnimation openAnimationDuration:(CGFloat)openDuration closeAnimationDuration:(CGFloat)closeDuration
{
   if((self=[super init]))
   {
       self.arrayData=data;
       self.heightOfCell=cHeight;
       self.refView=rView;
       self.paddingTop=tPaddingTop;
       self.paddingLeft=tPaddingLeft;
       self.paddingRight=tPaddingRight;
       self.heightTableView=tHeightTableView;
       self.open=openDuration;
       self.close=closeDuration;
       CGRect reFrame=refView.frame;
       self.view.frame=CGRectMake(reFrame.origin.x-paddingLeft, reFrame.origin.y+reFrame.size.height+paddingTop, reFrame.size.width+paddingRight, heightTableView);
       self.view.layer.shadowColor=[[UIColor blackColor]CGColor];
       self.view.layer.shadowOffset=CGSizeMake(5.0f, 5.0f);
       self.view.layer.shadowOpacity=1.0f;
       self.view.layer.shadowRadius=5.0f;
       
       animationType=tAnimation;
   
   }
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.*/
- (void)viewDidLoad
{
    [super viewDidLoad];
    CGRect refFrame=refView.frame;
    uitableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, refFrame.size.width+paddingRight, (animationType==BOTH || animationType ==BLENDIN)? heightTableView:1) style:UITableViewStylePlain];
    uitableView.delegate=self;
    uitableView.dataSource=self;
    [self.view addSubview:uitableView];
    self.view.hidden=YES;
    if(animationType==BOTH || animationType==BLENDIN)
        [self.view setAlpha:1];
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return heightOfCell;

}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return [arrayData count];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  static NSString *cellName=@"cell";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellName];
    if(cell==nil)
    {
        cell=[[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellName]autorelease];
    }
    cell.textLabel.text=[arrayData objectAtIndex:indexPath.row];
    cell.textLabel.textAlignment=UITextAlignmentCenter;
    
    return cell;
                         
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [delegate dropDownCellSelected:indexPath.row];
    [self closeAnimation];
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0;

}
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
  return @"";
}
- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section{
    
	return @"";
	
}
#pragma mark -
#pragma mark DropDownViewDelegate
-(void)dropDownCellSelected:(NSInteger)returnIndex{
	
}	

#pragma mark -
#pragma mark Class Methods
- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}
-(void)openAnimation
{
    self.view.hidden=NO;
    if(animationType==BOTH || animationType==GROW)
        self.uitableView.frame = CGRectMake(uitableView.frame.origin.x,uitableView.frame.origin.y,uitableView.frame.size.width, heightTableView);
	
	if(animationType == BOTH || animationType == BLENDIN)
		self.view.alpha = 1;

}
-(void)closeAnimation
{
    
	if(animationType == BOTH || animationType == GROW)
		self.uitableView.frame = CGRectMake(uitableView.frame.origin.x,uitableView.frame.origin.y,uitableView.frame.size.width, 1);
	
	if(animationType == BOTH || animationType == BLENDIN)
		self.view.alpha = 0;
	[self performSelector:@selector(hideView) withObject:nil afterDelay:close];
}

-(void)hideView
{
    self.view.hidden=YES;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
