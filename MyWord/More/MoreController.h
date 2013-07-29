//
//  MoreController.h
//  MyWord
//
//  Created by CL7RNEC on 12-12-30.
//  Copyright (c) 2012年 CL7RNEC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MoreController : UIViewController<UITableViewDataSource,UITableViewDataSource,UIAlertViewDelegate>

@property (strong,nonatomic) NSDictionary *dicMore;
@property (strong,nonatomic) NSArray *arrMore;

-(void)initView;
-(void)initData;
/*
 desc:默认键盘设置
 @parame
 return:
 */
-(void)actionOpenKeyboard:(id)sender;
@end
