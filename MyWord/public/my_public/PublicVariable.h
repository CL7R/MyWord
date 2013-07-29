//
//  PublicVariable.h
//  
//
//  Created by cai liang on 11-8-30.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
//判断iphone5
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)
#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
//公共日志
#ifdef DEBUG
#define CLog(format, ...) NSLog(format, ## __VA_ARGS__)
#else
#define CLog(format, ...)
#endif

typedef enum{
    UPDATE_YES=1,
    UPDATE_NO
}updateEnum;

typedef enum{
    OPEN_KEYBOARD_YES=1,
    OPEN_KEYBOARD_NO
}keyEnum;

extern int updataFlag;
@interface PublicVariable : NSObject

@end
