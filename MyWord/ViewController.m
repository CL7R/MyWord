//
//  ViewController.m
//  MyWord
//
//  Created by CL7RNEC on 12-12-29.
//  Copyright (c) 2012年 CL7RNEC. All rights reserved.
//

#import "ViewController.h"
#import "TranslationController.h"
#import "WordController.h"
#import "MoreController.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self initView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation==UIInterfaceOrientationPortrait);
}
#pragma mark -init
-(void)initView{
    
    TranslationController *tran=[[TranslationController alloc]init];
    WordController *word=[[WordController alloc]init];
    MoreController *more=[[MoreController alloc]init];
    UINavigationController *navTran=[[UINavigationController alloc]initWithRootViewController:tran];
    UINavigationController *navWord=[[UINavigationController alloc]initWithRootViewController:word];
    UINavigationController *navMore=[[UINavigationController alloc]initWithRootViewController:more];
    [navTran.tabBarItem setTitle:NSLocalizedString(@"翻译", nil)];
    [navWord.tabBarItem setTitle:NSLocalizedString(@"我的单词", nil)];
    [navMore.tabBarItem setTitle:NSLocalizedString(@"更多", nil)];
    [navTran.tabBarItem setImage:imgBarTran];
    [navWord.tabBarItem setImage:imgBarWord];
    [navMore.tabBarItem setImage:imgBarMore];
    NSArray *arr=[NSArray arrayWithObjects:navTran, navWord,navMore,nil];
    self.viewControllers=arr;
    [tran release];
    [word release];
    [more release];
    [navTran release];
    [navWord release];
    [navMore release];
}
@end
