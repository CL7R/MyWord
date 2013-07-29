//
//  IFlySpeechController.h
//  MyWord
//  讯飞语音识别/合成
//  Created by CL7RNEC on 12-12-30.
//  Copyright (c) 2012年 CL7RNEC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "iFlyMSC/IFlyRecognizeControl.h"
#import "iFlyMSC/IFlySynthesizerControl.h"

#define H_CONTROL_ORIGIN CGPointMake(20, 70)
#define IFLY_ID     @"508a288f"
#define IFLY_URL    @"http://dev.voicecloud.cn:1028/index.htm"

@protocol IFlyRecognizeDelegate;

@interface IFlySpeechController : UIViewController<IFlyRecognizeControlDelegate>

@property(strong,nonatomic) IFlyRecognizeControl *iFlyRec;
@property(strong,nonatomic) IFlySynthesizerControl *iFlySyn;
@property(nonatomic,assign) id<IFlyRecognizeDelegate> delegate;
/*
 desc:获取单例
 @parame:
 return:IFlySpeechController
 */
+(IFlySpeechController *)getInstance;
/*
 desc:初始化语音识别
 @parame:
 return:
 */
-(void)initIFlyRecognize;
/*
 desc:初始化语音合成
 @parame:
 return:
 */
-(void)initIFlySynthesizer;
@end

@protocol IFlyRecognizeDelegate <NSObject>
/*
 desc:识别成功
 @parame:arrRecognize:识别结果
 return:
 */
-(void)recognizeOk:(NSArray *)arrRecognize;
/*
 desc:识别结束
 @parame:strError:错误描述
 return:
 */
-(void)recognizeEnd:(NSString *)strError;

@end