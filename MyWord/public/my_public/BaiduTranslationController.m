//
//  BaiduTranslationController.m
//  MyWord
//
//  Created by CL7RNEC on 13-4-8.
//  Copyright (c) 2013年 CL7RNEC. All rights reserved.
//

#import "BaiduTranslationController.h"
#import "TKAlertCenter.h"
#import "ASIHTTPRequest.h"
#import "JSON.h"
@interface BaiduTranslationController ()

@end

@implementation BaiduTranslationController

#pragma mark -
#pragma mark init
+(BaiduTranslationController *)getInstance{
    static BaiduTranslationController *tran;
    if(tran==nil){
        tran=[[BaiduTranslationController alloc]init];
    }
    return tran;
}
#pragma mark -
#pragma mark other
-(void)translationWord:(NSString *)word{
    NSString *urlTran=[[[NSString alloc]initWithFormat:
                        @"%@?client_id=%@&from=%@&to=%@&q=%@",
                        BAIDU_ID,BAIDU_ID,@"auto",@"auto",
                        [word stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]autorelease];
    NSURL *url=[NSURL URLWithString:urlTran];
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    [request setTimeOutSeconds:BAIDU_TIME_OUT];
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
    if ([_delegate respondsToSelector:@selector(baiduTranslationOk:)]) {
        [_delegate baiduTranslationOk:dic];
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
    if ([_delegate respondsToSelector:@selector(baiduTranslationFail)]) {
        [_delegate baiduTranslationFail];
    }
}
@end
