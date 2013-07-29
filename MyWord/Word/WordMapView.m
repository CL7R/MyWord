//
//  WordMapView.m
//  MyWord
//
//  Created by CL7RNEC on 13-1-6.
//  Copyright (c) 2013年 CL7RNEC. All rights reserved.
//

#import "WordMapView.h"
#import "BaiduMapController.h"
@implementation WordMapView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self initView];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/
-(void)dealloc{
    [_btnMyLocation release];
    [_btnZoomIn release];
    [_btnZoomOut release];
    [super dealloc];
}
#pragma mark - init
-(void)initView{
     BaiduMapController *baidu=[BaiduMapController getInstance];
    [baidu.mapView setFrame:CGRectMake(0, 0, 320, SCREEN_HEIGHT)];
    //当前位置
    _btnMyLocation=[UIButton buttonWithType:UIButtonTypeCustom];
    [_btnMyLocation setFrame:CGRectMake(10, 15, 35, 35)];
    [_btnMyLocation setBackgroundImage:imgMyLocation forState:UIControlStateNormal];
    _btnMyLocation.alpha=0.7;
    [baidu.mapView addSubview:_btnMyLocation];
    //放大
    _btnZoomIn=[UIButton buttonWithType:UIButtonTypeCustom];
    [_btnZoomIn setFrame:CGRectMake(275, 270, 35, 40)];
    [_btnZoomIn setBackgroundImage:imgZoomIn forState:UIControlStateNormal];
    _btnZoomIn.alpha=0.7;
    [baidu.mapView addSubview:_btnZoomIn];
    //缩小
    _btnZoomOut=[UIButton buttonWithType:UIButtonTypeCustom];
    [_btnZoomOut setFrame:CGRectMake(275, 310, 35, 40)];
    [_btnZoomOut setBackgroundImage:imgZoomOut forState:UIControlStateNormal];
    _btnZoomOut.alpha=0.7;
    [baidu.mapView addSubview:_btnZoomOut];
    [self addSubview: baidu.mapView];
}
@end
