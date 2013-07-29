//
//  WordDetailView.m
//  MyWord
//
//  Created by CL7RNEC on 12-12-30.
//  Copyright (c) 2012年 CL7RNEC. All rights reserved.
//

#import "WordDetailView.h"
#import <QuartzCore/QuartzCore.h>
@implementation WordDetailView

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
-(void)dealloc{
    [_btnSave release];
    [_btnEmphasis release];
    [_labWord release];
    [_texPhonetics release];
    [_labBrowseCounts release];
    [_imgvBrowseCounts release];
    [_texvTran release];
    [_texvMark release];
    [super dealloc];
}

#pragma mark - init
-(void)initView{
    [self setBackgroundColor:colorBackground];
    //保存按钮
    _btnSave=[UIButton buttonWithType:UIButtonTypeCustom];
    [_btnSave setFrame:CGRectMake(0, 0, 50, 30)];
    [_btnSave setBackgroundImage:imgUpdate forState:UIControlStateNormal];
    //单词
    _labWord=[[UILabel alloc]initWithFrame:CGRectMake(50, 20, 150, 30)];
    [_labWord setBackgroundColor:colorLab];
    _labWord.font=[UIFont systemFontOfSize:25];
    [self addSubview:_labWord];
    //音标
    _texPhonetics=[[UITextField alloc]initWithFrame:CGRectMake(10, 70, 300, 30)];
    _texPhonetics.borderStyle = UITextBorderStyleRoundedRect;
    _texPhonetics.font=[UIFont systemFontOfSize:15];
    [self addSubview:_texPhonetics];
    //浏览次数
    _labBrowseCounts=[[UILabel alloc]initWithFrame:CGRectMake(285, 10, 20, 15)];
    [_labBrowseCounts setBackgroundColor:colorLab];
    [self addSubview:_labBrowseCounts];
    _imgvBrowseCounts=[[UIImageView alloc]initWithFrame:CGRectMake(265, 10, 15, 15)];
    [_imgvBrowseCounts setImage:imgBrowse];
    [self addSubview:_imgvBrowseCounts];
    //重点
    _btnEmphasis=[UIButton buttonWithType:UIButtonTypeCustom];
    [_btnEmphasis setFrame:CGRectMake(10, 20, 30, 30)];
    [_btnEmphasis setBackgroundImage:imgSave forState:UIControlStateNormal];
    [self addSubview:_btnEmphasis];
    //翻译结果
    _texvTran=[[UITextView alloc]initWithFrame:CGRectMake(10, 120, 300, 100)];
    _texvTran.tag=TEXV_TRAN;
    [_texvTran.layer setBorderColor:[colorBorder CGColor]];
    [_texvTran.layer setBorderWidth:1.0];
    [_texvTran.layer setCornerRadius:8.0];
    [_texvTran.layer setMasksToBounds:YES];
    _texvTran.clipsToBounds = YES;
    [self addSubview:_texvTran];
    //备注
    _texvMark=[[UITextView alloc]initWithFrame:CGRectMake(10, 240, 300, 50)];
    _texvMark.tag=TEXV_MARK;
    [_texvMark.layer setBorderColor:[colorBorder CGColor]];
    [_texvMark.layer setBorderWidth:1.0];
    [_texvMark.layer setCornerRadius:8.0];
    [_texvMark.layer setMasksToBounds:YES];
    _texvMark.clipsToBounds = YES;
    [self addSubview:_texvMark];
}
@end
