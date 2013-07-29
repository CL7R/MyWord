//
//  WordDetailView.h
//  MyWord
//
//  Created by CL7RNEC on 12-12-30.
//  Copyright (c) 2012年 CL7RNEC. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum{
    TEXV_TRAN=1,
    TEXV_MARK
}texvEnum;

@interface WordDetailView : UIView

@property (strong,nonatomic) UIButton *btnSave;
@property (strong,nonatomic) UIButton *btnEmphasis;
@property (strong,nonatomic) UILabel *labWord;
@property (strong,nonatomic) UITextField *texPhonetics;
@property (strong,nonatomic) UILabel *labBrowseCounts;
@property (strong,nonatomic) UIImageView *imgvBrowseCounts;
@property (strong,nonatomic) UITextView *texvTran;
@property (strong,nonatomic) UITextView *texvMark;

-(void)initView;
@end
