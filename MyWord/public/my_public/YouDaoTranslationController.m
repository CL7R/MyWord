//
//  YouDaoTranslationController.m
//  MyWord
//  有道翻译
//  Created by CL7RNEC on 12-12-30.
//  Copyright (c) 2012年 CL7RNEC. All rights reserved.
//

#import "YouDaoTranslationController.h"
#import "TKAlertCenter.h"
#import "ASIHTTPRequest.h"
#import "JSON.h"
@implementation YouDaoTranslationController

#pragma mark -
#pragma mark init
+(YouDaoTranslationController *)getInstance{
    static YouDaoTranslationController *tran;
    if(tran==nil){
        tran=[[YouDaoTranslationController alloc]init];
    }
    return tran;
}
#pragma mark -
#pragma mark other
-(void)translationWord:(NSString *)word{
    NSString *urlTran=[[[NSString alloc]initWithFormat:
                         @"%@?keyfrom=%@&key=%@&type=%@&doctype=%@&version=%@&q=%@",
                         YOUDAO_URL,YOUDAO_FROM,YOUDAO_ID,YOUDAO_TYPE,YOUDAO_DOC_TYPE,YOUDAO_VERSION,
                         [word stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]autorelease];
    NSURL *url=[NSURL URLWithString:urlTran];
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    [request setTimeOutSeconds:YOUDAO_TIME_OUT];
    [request setDelegate:self];
    //异步请求
    [request startAsynchronous];
}
//异步请求成功回调函数
-(void)requestFinished:(ASIHTTPRequest *)request
{
    NSString *response=[request responseString];
    NSDictionary *dic=[response JSONValue];
    //代理
    if ([_delegate respondsToSelector:@selector(translationOk:)]) {
        [_delegate translationOk:dic];
    }
    /*翻译和音标
    NSArray *arr=[dic objectForKey:@"translation"];
    NSString *str=[[[dic objectForKey:@"basic"]objectForKey:@"explains"] JSONFragment];
    */
}
//异步请求失败回调函数
-(void)requestFailed:(ASIHTTPRequest *)request
{
    NSError*error =[request error];
    NSLog(@"\n[requestFailed]%@",error);
    //代理
    if ([_delegate respondsToSelector:@selector(translationFail)]) {
        [_delegate translationFail];
    }
}
@end
