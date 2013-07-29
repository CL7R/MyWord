//
//  YouDaoTranslationController.h
//  MyWord
//
//  Created by CL7RNEC on 12-12-30.
//  Copyright (c) 2012年 CL7RNEC. All rights reserved.
//

#import <Foundation/Foundation.h>

#define YOUDAO_URL      @"http://fanyi.youdao.com/fanyiapi.do"
#define YOUDAO_FROM     @"CL7RAPI"
#define YOUDAO_ID       @"1562321494"
#define YOUDAO_TYPE     @"data"
#define YOUDAO_DOC_TYPE @"json"
#define YOUDAO_VERSION  @"1.1"
#define YOUDAO_TIME_OUT 5

@protocol YouDaoTranslationDelegate;

@interface YouDaoTranslationController : NSObject

@property(nonatomic,assign) id<YouDaoTranslationDelegate> delegate;
/*
 desc:获取单例
 @parame:
 return:YouDaoTranslationController
 */
+(YouDaoTranslationController *)getInstance;
/*
 desc:翻译单词
 @parame:word 要翻译的单词
 return:
 */
-(void)translationWord:(NSString *)word;
@end

@protocol YouDaoTranslationDelegate <NSObject>

/*
 desc:翻译成功后处理
 @parame:dicWord 翻译结果
 return:
 */
-(void)translationOk:(NSDictionary *)dicWord;
/*
 desc:翻译失败后处理
 @parame:
 return:
 */
-(void)translationFail;
@end
