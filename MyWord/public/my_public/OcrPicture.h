//
//  OcrPicture.h
//  MyWord
//
//  Created by CL7RNEC on 13-3-21.
//  Copyright (c) 2013年 CL7RNEC. All rights reserved.
//
#include "baseapi.h"
#include "environ.h"
#import <Foundation/Foundation.h>
#import "pix.h"
namespace tesseract {
    class TessBaseAPI;
};

@interface OcrPicture : NSObject{
    tesseract::TessBaseAPI *tesseract;
    uint32_t *pixels;
}
@property (strong,nonatomic) NSString *strWord;
/*
 desc:获取单例
 @parame:
 return:OcrPicture
 */
+(OcrPicture *)getInstance;
/*
 desc:初始化
 @parame:
 return:
 */
-(void)initData;
/*
 desc:二值化
 @parame:
 return:
 */
- (UIImage *)convertToGrayscale:(UIImage*)img;
/*
 desc:灰度
 @parame:
 return:
 */
-(UIImage *)grayImage:(UIImage *)source;
/*
 desc:图像识别
 @parame:
 return:
 */
-(void)recognizePicture:(UIImage *)image;
@end
