//
//  BaiduMapController.m
//  MyWord
//
//  Created by CL7RNEC on 12-12-30.
//  Copyright (c) 2012年 CL7RNEC. All rights reserved.
//

#import "BaiduMapController.h"

@interface BaiduMapController ()

@end

@implementation BaiduMapController

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)dealloc{
    [_mapManager release];
    [_mapView release];
    [_myLocation release];
    [super dealloc];
}
#pragma mark - init
+(BaiduMapController *)getInstance{
    static BaiduMapController *map;
    if(map==nil){
        map=[[BaiduMapController alloc]init];
    }
    return map;
}
-(void)initBaiduMap{
    _mapManager = [[BMKMapManager alloc]init];
	BOOL ret = [_mapManager start:BAIDU_ID generalDelegate:(id)self];
	if (!ret) {
		//CLog(@"manager start failed!");
	}
}
-(void)initData{
    _mapView=[[BMKMapView alloc]init];
    _mapView.delegate=self;
    _mapView.showsUserLocation=YES;
    //自带定位
    _myLocation=[[CLLocationManager alloc]init];
    [_myLocation startUpdatingLocation];
    _myCoor.latitude=[[_myLocation location] coordinate].latitude+latitudeDisplacement;
    _myCoor.longitude=[[_myLocation location] coordinate].longitude+longitudeDisplacement;
}
#pragma mark - other
-(void)getMyLocation{
    //_mapView.showsUserLocation=YES;
    _myCoor.latitude=[[_myLocation location] coordinate].latitude+latitudeDisplacement;
    _myCoor.longitude=[[_myLocation location] coordinate].longitude+longitudeDisplacement;
}
-(void)backMyLocation{
    [_mapView setCenterCoordinate:_myCoor animated:YES];
}
-(void)mapZoomIn{
    [_mapView zoomIn];
}
-(void)mapZoomOut{
    [_mapView zoomOut];
}
#pragma mark - baiduDelegate
//用户位置更新
- (void)mapView:(BMKMapView *)mapView didUpdateUserLocation:(BMKUserLocation *)userLocation{    
    _myCoor.latitude=userLocation.location.coordinate.latitude;
    _myCoor.longitude=userLocation.location.coordinate.longitude;
    //NSLog(@"\n[didUpdateToLocation]%f",_myCoor.latitude);
}
//地图上添加标注
- (BMKAnnotationView *)mapView:(BMKMapView *)mV
             viewForAnnotation:(id <BMKAnnotation>)annotation{
    BMKPinAnnotationView *pinView = nil;
    //static NSString *defaultPinID = @"myLocation";
    //pinView = (BMKPinAnnotationView *)[self.mapView dequeueReusableAnnotationViewWithIdentifier:defaultPinID];
    if ( pinView == nil )
    {
        pinView = [[[BMKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:nil] autorelease];
    }
    if(![annotation isKindOfClass:[BMKUserLocation class]]){
        pinView.pinColor = BMKPinAnnotationColorRed;  //设置指针颜色
        pinView.canShowCallout = YES;
        pinView.animatesDrop=YES;
    }
    return pinView;
}

@end
