//
//  TranslationView.m
//  MyWord
//
//  Created by CL7RNEC on 12-12-30.
//  Copyright (c) 2012年 CL7RNEC. All rights reserved.
//

#import "TranslationView.h"
#import <QuartzCore/QuartzCore.h>

@implementation TranslationView

-(void)dealloc{
    [_btnSpeech release];
    [_btnPicture release];
    [_btnSave release];
    [_labWord release];
    [_labPhonetics release];
    [_texvTran release];
    [_searWord release];
    [_segCon release];
    [super dealloc];
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self initView];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/
#pragma mark -
#pragma mark init
-(void)initView{
    //背景颜色
    [self setBackgroundColor:colorBackground];
    //语音按钮
    _btnSpeech=[UIButton buttonWithType:UIButtonTypeCustom];
    [_btnSpeech setFrame:CGRectMake(0, 0, 40, 40)];
    [_btnSpeech setBackgroundColor:colorSpeech];
    [_btnSpeech setBackgroundImage:imgSpeech forState:UIControlStateNormal];
    [self addSubview:_btnSpeech];
    //图像识别按钮
    _btnPicture=[UIButton buttonWithType:UIButtonTypeCustom];
    [_btnPicture retain];
    [_btnPicture setFrame:CGRectMake(280, 0, 40, 40)];
    [_btnPicture setBackgroundColor:colorSpeech];
    [_btnPicture setBackgroundImage:imgPicture forState:UIControlStateNormal];
    [self addSubview:_btnPicture];
    //单词翻译
    _searWord=[[UISearchBar alloc]initWithFrame:CGRectMake(40, 0, 240, 40)];
    [_searWord setTintColor:colorBar];
    [_searWord setShowsCancelButton:NO];
    [self addSubview:_searWord];
    //单词
    _labWord=[[UILabel alloc]initWithFrame:CGRectMake(10, 90, 100, 40)];
    [_labWord setBackgroundColor:colorLab];
    [_labWord setFont:[UIFont systemFontOfSize:25]];
    [self addSubview:_labWord];
    [_labWord setHidden:YES];
    //音标
    _labPhonetics=[[UILabel alloc]initWithFrame:CGRectMake(120, 90, 150, 40)];
    [_labPhonetics setBackgroundColor:colorLab];
    [self addSubview:_labPhonetics];
    [_labPhonetics setHidden:YES];
    //翻译结果
    _texvTran=[[UITextView alloc]initWithFrame:CGRectMake(10, 130, 300, 100)];
    [_texvTran.layer setShadowColor:[colorShadow CGColor]];
    [_texvTran.layer setBorderColor:[colorBorder CGColor]];
    [_texvTran.layer setBorderWidth:1.0];
    [_texvTran.layer setCornerRadius:8.0];
    [_texvTran.layer setMasksToBounds:YES];
    _texvTran.clipsToBounds = YES;
    [self addSubview:_texvTran];
    [_texvTran setHidden:YES];
    //保存
    _btnSave=[UIButton buttonWithType:UIButtonTypeCustom];
    [_btnSave setFrame:CGRectMake(10, 250, 300, 36)];
    [_btnSave setTitle:NSLocalizedString(@"收藏单词", nil) forState:UIControlStateNormal];
    [_btnSave setBackgroundImage:imgSave forState:UIControlStateNormal];
    [self addSubview:_btnSave];
    [_btnSave setHidden:YES];
    //翻译渠道
    NSArray *arrName = [NSArray arrayWithObjects:NSLocalizedString(@"有道翻译", nil),NSLocalizedString(@"百度翻译", nil), nil];
    _segCon=[[UISegmentedControl alloc] initWithItems:arrName];
    [_segCon setSegmentedControlStyle:UISegmentedControlStyleBordered];
    //[_segCon setTintColor:colorNavBar];
    _segCon.frame=CGRectMake(10, 40, 300, 36);
    [self addSubview:_segCon];
}
@end
