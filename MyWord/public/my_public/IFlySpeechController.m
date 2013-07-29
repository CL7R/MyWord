//
//  IFlySpeechController.m
//  MyWord
//
//  Created by CL7RNEC on 12-12-30.
//  Copyright (c) 2012年 CL7RNEC. All rights reserved.
//

#import "IFlySpeechController.h"

@interface IFlySpeechController ()

@end

@implementation IFlySpeechController

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)dealloc{
    [_iFlyRec release];
    [_iFlySyn release];
    [super dealloc];
}
#pragma mark -
#pragma mark init
+(IFlySpeechController *)getInstance{
    static IFlySpeechController *iFly;
    if(iFly==nil){
        iFly=[[IFlySpeechController alloc]init];
    }
    return iFly;
}
-(void)initIFlyRecognize{
    NSString *initParam = [[NSString alloc] initWithFormat:@"server_url=%@,appid=%@",IFLY_URL,IFLY_ID];
    _iFlyRec = [[IFlyRecognizeControl alloc] initWithOrigin:H_CONTROL_ORIGIN theInitParam:initParam];
    [initParam release];
    // 设置语音识别控件的参数
	[_iFlyRec setEngine:@"sms" theEngineParam:nil theGrammarID:nil];
	[_iFlyRec setSampleRate:16000];
	_iFlyRec.delegate = (id)self;    
    [self.view addSubview:_iFlyRec];
}
-(void)initIFlySynthesizer{
    NSString *initParam = [[NSString alloc] initWithFormat:@"server_url=%@,appid=%@",IFLY_URL,IFLY_ID];
    _iFlySyn = [[IFlySynthesizerControl alloc] initWithOrigin:H_CONTROL_ORIGIN theInitParam:initParam];
    [initParam release];
    // 配置语音合成控件，比如采样率，委托对象，发音人等等。
	_iFlySyn.delegate = (id)self;
    [self.view addSubview:_iFlySyn];
}
#pragma mark - recognizeDelegate
//识别结果回调函数
- (void)onResult:(IFlyRecognizeControl *)iFlyRecognizeControl theResult:(NSArray *)resultArray
{
	//[[resultArray objectAtIndex:0] objectForKey:@"NAME"];
    if ([_delegate respondsToSelector:@selector(recognizeOk:)]) {
        [_delegate recognizeOk:resultArray];
    }
}
//识别结束回调函数，当整个会话过程结束时候会调用这个函数
- (void)onRecognizeEnd:(IFlyRecognizeControl *)iFlyRecognizeControl theError:(SpeechError) error
{
    [self.view removeFromSuperview];
	//[iFlyRecognizeControl getErrorDescription:error];
	//NSLog(@"getUpflow:%d,getDownflow:%d",[iFlyRecognizeControl getUpflow],[iFlyRecognizeControl getDownflow]);
	if (error!=0) {
        if ([_delegate respondsToSelector:@selector(recognizeEnd:)]) {
            [_delegate recognizeEnd:[iFlyRecognizeControl getErrorDescription:error]];
        }
    }
}
@end
