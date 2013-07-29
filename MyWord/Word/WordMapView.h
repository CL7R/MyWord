//
//  WordMapView.h
//  MyWord
//
//  Created by CL7RNEC on 13-1-6.
//  Copyright (c) 2013年 CL7RNEC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WordMapView : UIView

@property(strong,nonatomic) UIButton *btnMyLocation;
@property(strong,nonatomic) UIButton *btnZoomIn;
@property(strong,nonatomic) UIButton *btnZoomOut;

-(void)initView;
@end
