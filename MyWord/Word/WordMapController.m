//
//  WordMapController.m
//  MyWord
//
//  Created by CL7RNEC on 12-12-30.
//  Copyright (c) 2012年 CL7RNEC. All rights reserved.
//

#import "WordMapController.h"
#import "BaiduMapController.h"
#import "MyWords.h"
#import "WordMapView.h"
@interface WordMapController ()

@end

@implementation WordMapController

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
	// Do any additional setup after loading the view.
    [self initData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc{
    [_arrWord release];
    //[_wordMapView release];
    [super dealloc];
}
#pragma mark - init
-(void)initData{
    self.navigationItem.title=NSLocalizedString(@"单词分布", nil);
    //初始化地图
     _baidu=[BaiduMapController getInstance];    
    //视图
    _wordMapView=[[WordMapView alloc]initWithFrame:CGRectMake(0, 0, 320, SCREEN_HEIGHT)];
    //初始化事件
    [_wordMapView.btnMyLocation addTarget:self action:@selector(actionMyLocation:) forControlEvents:UIControlEventTouchUpInside];
    [_wordMapView.btnZoomIn addTarget:self action:@selector(actionZoomIn:) forControlEvents:UIControlEventTouchUpInside];
    [_wordMapView.btnZoomOut addTarget:self action:@selector(actionZoomOut:) forControlEvents:UIControlEventTouchUpInside];
    
    self.view=_wordMapView;
    [self initWordMap];
}
-(void)initWordMap{
    NSMutableArray *arr=[[NSMutableArray alloc]init];
    NSArray *arrTemp=[NSArray arrayWithArray:_baidu.mapView.annotations];
    [_baidu.mapView removeAnnotations:arrTemp];
    for(MyWords *word in _arrWord){
        CLLocationCoordinate2D newCoord = {[word.latitude floatValue],[word.longitude floatValue]};
        BMKPointAnnotation* item = [[BMKPointAnnotation alloc]init];
        item.coordinate = newCoord;
        item.title = word.word;
        item.subtitle=word.translation;
        [arr addObject:item];
        [item release];
    }
    [_baidu.mapView addAnnotations:arr];
    [arr release];
}
#pragma mark - action
-(void)actionMyLocation:(id)sender{
    [_baidu backMyLocation];
}
-(void)actionZoomIn:(id)sender{
    [_baidu mapZoomIn];
}
-(void)actionZoomOut:(id)sender{
    [_baidu mapZoomOut];
}
@end
