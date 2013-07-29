//
//  WordDetailController.h
//  MyWord
//
//  Created by CL7RNEC on 12-12-30.
//  Copyright (c) 2012年 CL7RNEC. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WordDetailView;
@class MyWords;
@class WordController;
@interface WordDetailController : UIViewController<UITextViewDelegate,UITextFieldDelegate>

@property (strong,nonatomic) WordDetailView *detailView;
@property (strong,nonatomic) MyWords *word;
@property (strong,nonatomic) WordController *wordCon;
-(void)initData;
-(void)actionSave:(id)sender;
-(void)actionEmphasis:(id)sender;
-(void)actionKeyboardReturn:(id)sender;
@end
