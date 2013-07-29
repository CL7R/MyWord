//
//  TranslationController.h
//  MyWord
//
//  Created by CL7RNEC on 12-12-30.
//  Copyright (c) 2012年 CL7RNEC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YouDaoTranslationController.h"
#import "IFlySpeechController.h"
#import "MBProgressHUD.h"
@class TranslationView;

@interface TranslationController : UIViewController<UISearchBarDelegate,YouDaoTranslationDelegate,IFlyRecognizeDelegate,UIAlertViewDelegate,UIImagePickerControllerDelegate>

@property(strong,nonatomic) TranslationView *tranView;
@property(strong,nonatomic) YouDaoTranslationController *youdao;
@property(strong,nonatomic) NSDictionary *dicWord;
@property(strong,nonatomic) MBProgressHUD *progress;

-(void)initData;
/*
 desc:字母校验
 @parame:strAlp:待校验字母
 return:
 */
-(BOOL)checkAlphabet:(NSString *)strAlp;
/*
 desc：开启进度条
 parame：
 strInfo：进度条的文字描述
 return：
 */
-(void)startProg:(NSString *)strInfo;
/*
 desc：关闭进度条
 parame：
 return：
 */
-(void)endProg;
/*
 desc:点击语音按钮
 @parame
 return:
 */
-(void)actionSpeech:(id)sender;
/*
 desc:点击图像识别按钮
 @parame
 return:
 */
-(void)actionOcr:(id)sender;
/*
 desc:点击保存按钮
 @parame
 return:
 */
-(void)actionSave:(id)sender;
/*
 desc:点击键盘返回键
 @parame
 return:
 */
-(void)actionKeyboardReturn:(id)sender;
@end
