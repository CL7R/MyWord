//
//  AboutMeView.m
//  MyWord
//
//  Created by CL7RNEC on 13-1-8.
//  Copyright (c) 2013年 CL7RNEC. All rights reserved.
//

#import "AboutMeView.h"

@implementation AboutMeView

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

-(void)initView{
    [self setBackgroundColor:colorBackground];
    //微信图片
    UIImageView *img=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"me"]];
    [img setFrame:CGRectMake(30, 10, 260, 260)];
    //文字
    UILabel *lab=[[UILabel alloc]initWithFrame:CGRectMake(10, 270, 300, 50)];
    lab.text=NSLocalizedString(@"您如果有什么问题，可以通过微信联系我。也可以通过新浪微博：", nil);
    lab.lineBreakMode =UILineBreakModeWordWrap;
    lab.numberOfLines=3;
    [lab setBackgroundColor:colorLab];
    //微博文字
    UILabel *labWeibo=[[UILabel alloc]initWithFrame:CGRectMake(10, 320, 300, 30)];
    labWeibo.text=NSLocalizedString(@"我的新浪微博名称：CL7R", nil);
    [labWeibo setBackgroundColor:colorLab];
    [self addSubview:img];
    [self addSubview:lab];
    [self addSubview:labWeibo];
    [img release];
    [lab release];
    [labWeibo release];
}
@end
