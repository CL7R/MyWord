//
//  PublicStyle.h
//  
//  样式类，图片、颜色、大小等
//  Created by CL7RNEC on 12-4-9.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#define RGB(r,g,b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1.0]

typedef enum{
    STYLE_1=1,
    STYLE_2,
    STYLE_3
}style;
//整体
extern UIImage *imgBarTran;
extern UIImage *imgBarWord;
extern UIImage *imgBarMore;
extern UIColor *colorBackground;
extern UIColor *colorNavBar;
//翻译
extern UIColor *colorBar;
extern UIImage *imgSpeech;
extern UIImage *imgSave;
extern UIColor *colorSpeech;
extern UIColor *colorBorder;
extern UIColor *colorShadow;
extern UIColor *colorLab;
extern UIImage *imgPicture;
extern UIImage *imgPictureFrame;
//我的单词
extern UIImage *imgMap;
extern UIImage *imgAll;
extern UIImage *imgEmphasisNo;
extern UIImage *imgEmphasisYes;
extern UIImage *imgAlp;
extern UIImage *imgDate;
extern UIImage *imgUpdate;
extern UIImage *imgBrowse;
extern UIImage *imgMyLocation;
extern UIImage *imgZoomIn;
extern UIImage *imgZoomOut;
//更多
@interface PublicStyle : NSObject
+(void)initStyle:(int)styleFlag;    //初始化样式
@end
