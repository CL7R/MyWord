//
//  WordMapController.h
//  MyWord
//
//  Created by CL7RNEC on 12-12-30.
//  Copyright (c) 2012年 CL7RNEC. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BaiduMapController;
@class WordMapView;
@interface WordMapController : UIViewController

@property (strong,nonatomic) BaiduMapController *baidu;
@property (strong,nonatomic) WordMapView *wordMapView;
@property (strong,nonatomic) NSArray *arrWord;

-(void)initData;
-(void)initWordMap;

-(void)actionMyLocation:(id)sender;
-(void)actionZoomIn:(id)sender;
-(void)actionZoomOut:(id)sender;
@end
