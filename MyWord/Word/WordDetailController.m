//
//  WordDetailController.m
//  MyWord
//
//  Created by CL7RNEC on 12-12-30.
//  Copyright (c) 2012年 CL7RNEC. All rights reserved.
//

#import "WordDetailController.h"
#import "WordDetailView.h"
#import "MyWords.h"
#import "WordController.h"
#import "DataDao.h"
#import "TKAlertCenter.h"
@interface WordDetailController ()

@end

int updataFlag;

@implementation WordDetailController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)viewWillDisappear:(BOOL)animated{
    [self performSelector:@selector(actionSave:) withObject:nil];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self initData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc{
    //[_detailView release];
    [_word release];
    [_wordCon release];
    [super dealloc];
}
#pragma mark - init
-(void)initData{
    self.navigationItem.title=NSLocalizedString(@"我的单词", nil);
    CLog(@"\n[initData]%@",_word.browseCount);
    //浏览次数+1
    _word.browseCount=[NSNumber numberWithInt:[_word.browseCount intValue]+1];
    DataDao *data=[DataDao getInstance];
    [data updateWord:_word];
    _detailView=[[WordDetailView alloc]initWithFrame:CGRectMake(0, 0, 320, SCREEN_HEIGHT)];    
    //右侧按钮
    //UIBarButtonItem *barbtn=[[UIBarButtonItem alloc]initWithCustomView:_detailView.btnSave];
    //self.navigationItem.rightBarButtonItem=barbtn;
    //[barbtn release];
    //语音
    _detailView.texPhonetics.placeholder=NSLocalizedString(@"音标", nil);
    [_detailView.texPhonetics addTarget:self action:@selector(actionKeyboardReturn:) forControlEvents:UIControlEventEditingDidEndOnExit];
    if (_word) {
        _detailView.labWord.text=_word.word;
        _detailView.texPhonetics.text=_word.phonetics;
        _detailView.labBrowseCounts.text=[_word.browseCount stringValue];
        _detailView.texvTran.text=_word.translation;
        _detailView.texvMark.text=_word.mark;
        if ([_word.isEmphasis intValue]==1) {
            [_detailView.btnEmphasis setBackgroundImage:imgEmphasisYes forState:UIControlStateNormal];
        }
        else{
            [_detailView.btnEmphasis setBackgroundImage:imgEmphasisNo forState:UIControlStateNormal];
        }
    }
    //保存
    //[_detailView.btnSave addTarget:self action:@selector(actionSave:) forControlEvents:UIControlEventTouchUpInside];
    //重点
    [_detailView.btnEmphasis addTarget:self action:@selector(actionEmphasis:) forControlEvents:UIControlEventTouchUpInside];
    //翻译
    _detailView.texvTran.delegate=(id)self;
    //备注
    _detailView.texvMark.delegate=(id)self;
    
    self.view=_detailView;
}
#pragma mark - action
-(void)actionSave:(id)sender{
    if ([_detailView.texvTran.text length]>0) {
        _word.phonetics=_detailView.texPhonetics.text;
        _word.translation=_detailView.texvTran.text;
        _word.mark=_detailView.texvMark.text;
        DataDao *data=[DataDao getInstance];
        if([data updateWord:_word]){
            updataFlag=UPDATE_YES;
            //[[TKAlertCenter defaultCenter] postAlertWithMessage:NSLocalizedString(@"恭喜您，更新成功", nil)];
            //[self.navigationController popToViewController:_wordCon animated:YES];
        }
        else{
            //[[TKAlertCenter defaultCenter] postAlertWithMessage:NSLocalizedString(@"很抱歉，更新失败", nil)];
        }
    }
    else{
        //[[TKAlertCenter defaultCenter] postAlertWithMessage:NSLocalizedString(@"翻译内容不能为空", nil)];
    }
}
-(void)actionEmphasis:(id)sender{
    if ([_word.isEmphasis intValue]==0) {
        [_detailView.btnEmphasis setBackgroundImage:imgEmphasisYes forState:UIControlStateNormal];
        _word.isEmphasis=[NSNumber numberWithInt:1];
    }
    else{
        [_detailView.btnEmphasis setBackgroundImage:imgEmphasisNo forState:UIControlStateNormal];
        _word.isEmphasis=[NSNumber numberWithInt:0];
    }
}
-(void)actionKeyboardReturn:(id)sender{
    //隐藏键盘
    [_detailView.texvTran resignFirstResponder];
    [_detailView.texvMark resignFirstResponder];
    [_detailView.texPhonetics resignFirstResponder];
}
#pragma mark - super
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    //隐藏键盘
    UITouch *touch = [touches anyObject];
    UIView *view = (UIView *)[touch view];
    CLog(@"\n[touchesBegan]%@,%@,",self.view,view);
    if (view == self.view) {
        [_detailView.texvTran resignFirstResponder];
        [_detailView.texvMark resignFirstResponder];
        [_detailView.texPhonetics resignFirstResponder];
    }
}
#pragma mark - textViewDelegate
-(BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    if (textView.tag==TEXV_MARK||textView.tag==TEXV_TRAN) {
        CGRect fram=_detailView.frame;
        [UIView beginAnimations:@"view" context:nil];
        [UIView setAnimationDuration:0.3];
        [_detailView setFrame:CGRectMake(0, -120, fram.size.width, fram.size.height)];
        [UIView commitAnimations];
    }
    return YES;
}
-(BOOL)textViewShouldEndEditing:(UITextView *)textView{
    if (textView.tag==TEXV_MARK||textView.tag==TEXV_TRAN) {
        CGRect fram=_detailView.frame;
        [UIView beginAnimations:@"view" context:nil];
        [UIView setAnimationDuration:0.3];
        [_detailView setFrame:CGRectMake(0, 0, fram.size.width, fram.size.height)];
        [UIView commitAnimations];
    }    
    return YES;
}
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if ([text isEqualToString:@"\n"]) {
        [_detailView.texvTran resignFirstResponder];
        [_detailView.texvMark resignFirstResponder];
    }
    return YES;
}
@end
