//
//  TranslationController.m
//  MyWord
//
//  Created by CL7RNEC on 12-12-30.
//  Copyright (c) 2012年 CL7RNEC. All rights reserved.
//
#import "TranslationController.h"
#import "TranslationView.h"
#import "YouDaoTranslationController.h"
#import "JSON.h"
#import "DataDao.h"
#import "BaiduMapController.h"
#import "PublicDate.h"
#import "IFlySpeechController.h"
#import "TKAlertCenter.h"
#import "MyWords.h"
#import "DefaultFileDataManager.h"
#import "OcrPicture.h"

@interface TranslationController ()

@end

int updataFlag;

@implementation TranslationController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
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
    [_tranView release];
    [_youdao release];
    [_dicWord release];
    [_progress release];
    [super dealloc];
}
#pragma mark -
#pragma mark init
-(void)initData{
    [self.navigationItem setTitle:NSLocalizedString(@"翻译", nil)];
    [self.navigationController.navigationBar setTintColor:colorNavBar];
    //翻译view
    _tranView=[[TranslationView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    //语音按钮增加事件
    [_tranView.btnSpeech addTarget:self action:@selector(actionSpeech:) forControlEvents:UIControlEventTouchUpInside];
    [_tranView.btnPicture addTarget:self action:@selector(actionOcr:) forControlEvents:UIControlEventTouchUpInside];
    //搜索框增加代理
    _tranView.searWord.delegate=(id)self;
    //是否弹出键盘
    [DefaultFileDataManager getFileData:DATA_FILE];
    if ([dicFileData objectForKey:@"openKeyboard"]) {
        if ([[dicFileData objectForKey:@"openKeyboard"] intValue]==OPEN_KEYBOARD_YES) {
            [_tranView.searWord becomeFirstResponder];
            [_tranView.searWord setFrame:CGRectMake(40, 0, 280, 40)];
            [_tranView.btnPicture setHidden:YES];
        }
    }
    else{
        [_tranView.searWord becomeFirstResponder];
        [_tranView.searWord setFrame:CGRectMake(40, 0, 280, 40)];
        [_tranView.btnPicture setHidden:YES];
    }
    //保存按钮增加事件
    [_tranView.btnSave addTarget:self action:@selector(actionSave:) forControlEvents:UIControlEventTouchUpInside];
    //翻译键盘增加返回事件
    //_tranView.texvTran.returnKeyType=UIReturnKeySearch;
    self.view=_tranView;
    //初始化有道翻译
    _youdao=[YouDaoTranslationController getInstance];
    _youdao.delegate=(id)self;
}
#pragma mark - other
-(BOOL)checkAlphabet:(NSString *)strAlp{
    NSString *strRegex = @"[A-Za-z]";
    NSPredicate *strTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", strRegex];
    return [strTest evaluateWithObject:strAlp];
}
-(void)startProg:(NSString *)strInfo{
    //设置加载等待
    _progress = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:_progress];
    [self.view bringSubviewToFront:_progress];
    _progress.delegate = (id)self;
    CGRect frame=_progress.frame;
    _progress.frame=CGRectMake(frame.origin.x, frame.origin.y-70, frame.size.width, frame.size.height);
    _progress.labelText = strInfo;
    [_progress show:YES];
}
-(void)endProg{
    [_progress removeFromSuperview];
    _progress = nil;
}
#pragma mark - action
-(void)actionSpeech:(id)sender{
    [self.view endEditing:YES];
    //调用语音界面
    IFlySpeechController *iFly=[IFlySpeechController getInstance];
    [iFly.view setFrame:CGRectMake(0, 0, 320, SCREEN_HEIGHT)];
    iFly.delegate=(id)self;
    [self.view addSubview:iFly.view];
    [iFly initIFlyRecognize];
    [iFly.iFlyRec start];
}
-(void)actionOcr:(id)sender{
    OcrPicture *ocr=[OcrPicture getInstance];
    [ocr initData];
    //打开照相机
    UIImagePickerController *picker = [[UIImagePickerController alloc]init];
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    picker.delegate = (id)self;
    picker.allowsEditing=YES;
    //
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
    [btn setFrame:CGRectMake(60, 100, 200, 71)];
    [btn setBackgroundImage:imgPictureFrame forState:UIControlStateNormal];
    [picker.view addSubview:btn];
    [self presentModalViewController:picker animated:YES];
}
-(void)actionSave:(id)sender{
    //校验
    if ([_tranView.texvTran.text length]>0) {
        //获取经纬度
        BaiduMapController *baidu=[BaiduMapController getInstance];
        [baidu getMyLocation];
        //获取单词索引，首字母大写，非字母都为其他，并做字母校验
        NSString *str=[[_tranView.labWord.text substringToIndex:1] uppercaseString];
        if(![self checkAlphabet:str]){
            str=@"其他";
        }
        //保存单词
        DataDao *data=[DataDao getInstance];
        _dicWord=[NSDictionary dictionaryWithObjectsAndKeys:_tranView.labWord.text,@"word",str,@"wordIndex",
                           _tranView.labPhonetics.text!=nil?_tranView.labPhonetics.text:@"",@"phonetics",_tranView.texvTran.text,@"translation",@"",@"mark",[NSNumber numberWithInt:1],@"browseCount",[NSNumber numberWithDouble:baidu.myCoor.latitude],@"latitude",[NSNumber numberWithDouble:baidu.myCoor.longitude],@"longitude",[NSNumber numberWithInt:0],@"isEmphasis", [PublicDate TimeTodate:[PublicDate getCurrentDate:1]dateType:1],@"createDate",[PublicDate TimeTodate:[PublicDate getCurrentDate:1]dateType:1],@"modifyDate",nil];
        [_dicWord retain];
        CLog(@"\n[actionSave]%@",_dicWord);
        switch ([data insertWord:_dicWord]) {
            case COREDATA_SUCCES:
                updataFlag=UPDATE_YES;
                [[TKAlertCenter defaultCenter] postAlertWithMessage:NSLocalizedString(@"恭喜您，收藏成功", nil)];
                break;
            case COREDATA_REPEAT:{
                UIAlertView *alert=[[[UIAlertView alloc]initWithTitle:NSLocalizedString(@"已收藏了", nil)
                                                              message:NSLocalizedString(@"您已收藏过该单词，是否要覆盖原有单词？", nil)
                                                             delegate:self
                                                    cancelButtonTitle:NSLocalizedString(@"覆盖", nil)
                                                    otherButtonTitles:NSLocalizedString(@"取消", nil), nil]autorelease];
                [alert show];
                break;
            }
            case COREDATA_ERROR:
                [[TKAlertCenter defaultCenter] postAlertWithMessage:NSLocalizedString(@"很抱歉，收藏失败", nil)];
                break;
            default:
                break;
        }
    }
    else{
        [[TKAlertCenter defaultCenter] postAlertWithMessage:NSLocalizedString(@"没有可收藏的信息", nil)];
    }
}
-(void)actionKeyboardReturn:(id)sender{
    //隐藏键盘
}
#pragma mark -
#pragma mark super
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    //隐藏键盘
    UITouch *touch = [touches anyObject];
    UIView *view = (UIView *)[touch view];
    if (view == self.view) {
        [_tranView.texvTran resignFirstResponder];
        [_tranView.searWord resignFirstResponder];
    }
}
#pragma mark - UISearchBarDelegate
-(void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
    [searchBar setShowsCancelButton:YES animated:YES];
    [_tranView.searWord setFrame:CGRectMake(40, 0, 280, 40)];
}
-(void)searchBarTextDidEndEditing:(UISearchBar *)searchBar{
    [searchBar setShowsCancelButton:NO animated:YES];
    [_tranView.searWord setFrame:CGRectMake(40, 0, 240, 40)];
    [_tranView.btnPicture setHidden:NO];
}
-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    //取消
    [searchBar setText:@""];
    [searchBar resignFirstResponder];
    [_tranView.searWord setFrame:CGRectMake(40, 0, 240, 40)];
    [_tranView.btnPicture setHidden:NO];
}
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    //搜索    
    [_youdao translationWord:searchBar.text];
    //[self startProg:NSLocalizedString(@"正在翻译，请稍等", nil)];
}
#pragma mark - alertDelegate
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex==0) {
        DataDao *data=[DataDao getInstance];
        NSArray *arr=[data queryWord:[_dicWord objectForKey:@"word"] queryType:QUERY_SEARCH_WORD];
        MyWords *word=(MyWords *)[arr objectAtIndex:0];
        [word setWord:[_dicWord objectForKey:@"word"]];
        [word setPhonetics:[_dicWord objectForKey:@"phonetics"]];
        [word setLatitude:[_dicWord objectForKey:@"latitude"]];
        [word setLongitude:[_dicWord objectForKey:@"longitude"]];
        [word setMark:[_dicWord objectForKey:@"mark"]];
        [word setIsEmphasis:[_dicWord objectForKey:@"isEmphasis"]];
        [word setTranslation:[_dicWord objectForKey:@"translation"]];
        [word setBrowseCount:[_dicWord objectForKey:@"browseCount"]];
        [word setCreateDate:[_dicWord objectForKey:@"createDate"]];
        [word setModifyDate:[_dicWord objectForKey:@"modifyDate"]];
        [word setWordIndex:[_dicWord objectForKey:@"wordIndex"]];
        if([data updateWord:word]){
            [[TKAlertCenter defaultCenter] postAlertWithMessage:NSLocalizedString(@"恭喜您，更新成功", nil)];
        }
        else{
            [[TKAlertCenter defaultCenter] postAlertWithMessage:NSLocalizedString(@"很抱歉，更新失败", nil)];
        }
    }
}
#pragma mark - youdaoDelegate
-(void)translationOk:(NSDictionary *)dicWord{
    if ([[dicWord objectForKey:@"basic"]objectForKey:@"explains"]) {
        
        _tranView.labWord.text=[dicWord objectForKey:@"query"];
        //音标
        if ([[dicWord objectForKey:@"basic"]objectForKey:@"phonetic"]) {
            _tranView.labPhonetics.text=[NSString stringWithFormat:@"[%@]",[[dicWord objectForKey:@"basic"]objectForKey:@"phonetic"]];
        }
        else{
            [[TKAlertCenter defaultCenter] postAlertWithMessage:NSLocalizedString(@"很抱歉，没有查到音标", nil)];
            _tranView.labPhonetics.text=@"";
        }
        //翻译结果
        NSArray *arr=[[dicWord objectForKey:@"basic"]objectForKey:@"explains"];
        CLog(@"\n[translationOk-1]%@",arr);
        NSMutableString *strTran=[[NSMutableString alloc]init];
        for (NSString *str in arr) {
            [strTran appendString:[NSString stringWithFormat:@"%@\n",str]];
        }
        _tranView.texvTran.text=strTran;
        [strTran release];
        [_tranView.searWord resignFirstResponder];
        //根据单词长度动态显示与音标的位置
        UIFont *font = [UIFont systemFontOfSize:25];
        //CGSize size = [_tranView.labWord.text sizeWithFont:font constrainedToSize:CGSizeMake(150.0f, 1000.0f) lineBreakMode:UILineBreakModeCharacterWrap];
        CGSize size =[_tranView.labWord.text sizeWithFont:font];
        CGRect frame =_tranView.labWord.frame;
        _tranView.labWord.frame=CGRectMake(frame.origin.x, frame.origin.y, size.width, frame.size.height);
        frame =_tranView.labPhonetics.frame;
        _tranView.labPhonetics.frame=CGRectMake(size.width+20, frame.origin.y, frame.size.width, frame.size.height);
        //显示翻译UI
        [_tranView.labWord setHidden:NO];
        [_tranView.labPhonetics setHidden:NO];
        [_tranView.texvTran setHidden:NO];
        [_tranView.btnSave setHidden:NO];
    }
    else{
        [[TKAlertCenter defaultCenter] postAlertWithMessage:NSLocalizedString(@"很抱歉，我们没有翻译出来", nil)];
        _tranView.texvTran.text=@"";
        _tranView.labPhonetics.text=@"";
        _tranView.labWord.text=@"";
    }
    //[self endProg];
}
-(void)translationFail{
    CLog(@"\n[translationFail]");
    [[TKAlertCenter defaultCenter] postAlertWithMessage:NSLocalizedString(@"很抱歉，我们没有翻译出来...", nil)];
    //[self endProg];
}
#pragma mark - iFlyRecognize
-(void)recognizeOk:(NSArray *)arrRecognize{
    CLog(@"\n[recognizeOk]%@",arrRecognize);
    _tranView.searWord.text=[[arrRecognize objectAtIndex:0]objectForKey:@"NAME"];
    [_youdao translationWord:[[arrRecognize objectAtIndex:0]objectForKey:@"NAME"]];
}
-(void)recognizeEnd:(NSString *)strError{
    CLog(@"\n[recognizeEnd]%@",strError);
}
#pragma mark - imagePicker
-(void)imagePickerController:(UIImagePickerController *)picker
didFinishPickingMediaWithInfo:(NSDictionary *)info{
    [picker dismissModalViewControllerAnimated:YES];
    UIImage* image = [info objectForKey:UIImagePickerControllerEditedImage];
    //截取图片尺寸
    CGRect rect1 = CGRectMake(60, 100, 200, 71);//创建矩形框
    //对图片进行截取
    UIImage * image2 = [UIImage imageWithCGImage:CGImageCreateWithImageInRect([image CGImage], rect1)];
    UIImageView *imgV=[[UIImageView alloc]initWithImage:image2];
    [self.view addSubview:imgV];
    OcrPicture *ocr=[OcrPicture getInstance];
    [ocr recognizePicture:image2];
    CLog(@"\n[imagePickerController]%@",ocr.strWord);
}
@end
