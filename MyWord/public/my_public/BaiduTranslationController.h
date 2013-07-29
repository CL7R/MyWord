//
//  BaiduTranslationController.h
//  MyWord
//
//  Created by CL7RNEC on 13-4-8.
//  Copyright (c) 2013年 CL7RNEC. All rights reserved.
//
#define BAIDU_URL      @"http://openapi.baidu.com/public/2.0/bmt/translate"
#define BAIDU_ID       @"ZR3SILmdBAiZyZ7EQimSv4wm"
#define BAIDU_TIME_OUT 5

#import <UIKit/UIKit.h>

@protocol BaiduTranslationDelegate;
@interface BaiduTranslationController : UIViewController

@property(nonatomic,assign) id<BaiduTranslationDelegate> delegate;
/*
 desc:获取单例
 @parame:
 return:YouDaoTranslationController
 */
+(BaiduTranslationController *)getInstance;
/*
 desc:翻译单词
 @parame:word 要翻译的单词
 return:
 */
-(void)translationWord:(NSString *)word;
@end

@protocol BaiduTranslationDelegate <NSObject>

/*
 desc:翻译成功后处理
 @parame:dicWord 翻译结果
 return:
 */
-(void)baiduTranslationOk:(NSDictionary *)dicWord;
/*
 desc:翻译失败后处理
 @parame:
 return:
 */
-(void)baiduTranslationFail;