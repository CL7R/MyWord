//
//  BaiduMapController.h
//  MyWord
//  百度地图
//  Created by CL7RNEC on 12-12-30.
//  Copyright (c) 2012年 CL7RNEC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "BMapKit.h"

#define BAIDU_ID @"DB2097F89A63502B47C4C3C76C62D830C71CB034"

#define longitudeDisplacement   0.012713     //经度偏移值google偏移0.00615
#define latitudeDisplacement    0.007077     //维度偏移值google偏移0.00145

@interface BaiduMapController : UIViewController<BMKMapViewDelegate,BMKAnnotation,BMKSearchDelegate,CLLocationManagerDelegate>

@property(strong, nonatomic) BMKMapManager* mapManager;
@property(strong, nonatomic) BMKMapView *mapView;
@property(nonatomic,assign) CLLocationCoordinate2D myCoor;
@property(strong,nonatomic) CLLocationManager *myLocation;
/*
 desc:获取单例
 @parame:
 return:BaiduMapController
 */
+(BaiduMapController *)getInstance;
/*
 desc:初始化百度地图
 @parame
 return:
 */
-(void)initBaiduMap;
/*
 desc:初始化
 @parame
 return:
 */
-(void)initData;
/*
 desc:获取当前位置
 @parame
 return:
 */
-(void)getMyLocation;
/*
 desc:回到当前位置
 @parame
 return:
 */
-(void)backMyLocation;
/*
 desc:放大地图
 @parame
 return:
 */
-(void)mapZoomIn;
/*
 desc:缩小地图
 @parame
 return:
 */
-(void)mapZoomOut;
@end
