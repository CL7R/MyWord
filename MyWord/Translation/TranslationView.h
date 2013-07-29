//
//  TranslationView.h
//  MyWord
//
//  Created by CL7RNEC on 12-12-30.
//  Copyright (c) 2012年 CL7RNEC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TranslationView : UIView

@property(strong,nonatomic)UIButton *btnSpeech;     //语音
@property(strong,nonatomic)UIButton *btnPicture;    //图像识别
@property(strong,nonatomic)UIButton *btnSave;       //收藏
@property(strong,nonatomic)UILabel *labWord;        //单词
@property(strong,nonatomic)UILabel *labPhonetics;   //音标
@property(strong,nonatomic)UITextView *texvTran;    //翻译结果
@property(strong,nonatomic)UISearchBar *searWord;   //单词翻译
@property(strong,nonatomic)UISegmentedControl *segCon;  //单词渠道

-(void)initView;
@end
