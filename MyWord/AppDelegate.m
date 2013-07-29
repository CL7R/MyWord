//
//  AppDelegate.m
//  MyWord
//
//  Created by CL7RNEC on 12-12-29.
//  Copyright (c) 2012年 CL7RNEC. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "BaiduMapController.h"
#import "DBCoreDataManage.h"
#import "DataDao.h"
#import "Flurry.h"

@implementation AppDelegate

- (void)dealloc
{
    [_window release];
    [_viewController release];
    [_baidu release];
    [_db release];
    [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [self initData];
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    // Override point for customization after application launch.
    self.viewController = [[[ViewController alloc] init] autorelease];
    self.window.rootViewController = self.viewController;
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    //应用关掉前保存数据
    [_db saveContext];
}

#pragma mark -init
-(void)initData{
    //初始化flurry
    [Flurry startSession:FLURRY_KEY];
    //初始化地图
    _baidu=[BaiduMapController getInstance];
    [_baidu initBaiduMap];
    [_baidu initData];
    //初始化coreData
    _db=[DBCoreDataManage getInstance];
    DataDao *data=[DataDao getInstance];
    [data initData];
    //初始化样式
    [PublicStyle initStyle:STYLE_1];
}
@end
