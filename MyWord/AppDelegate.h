//
//  AppDelegate.h
//  MyWord
//
//  Created by CL7RNEC on 12-12-29.
//  Copyright (c) 2012年 CL7RNEC. All rights reserved.
//

#import <UIKit/UIKit.h>

#define FLURRY_KEY @"Q8M8MTJ9TD9H7M6Z7YMJ"

@class ViewController;
@class BaiduMapController;
@class DBCoreDataManage;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) ViewController *viewController;
@property (strong, nonatomic) BaiduMapController *baidu;
@property (strong, nonatomic) DBCoreDataManage *db;

-(void)initData;
@end
