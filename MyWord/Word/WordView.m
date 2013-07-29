//
//  WordView.m
//  MyWord
//
//  Created by CL7RNEC on 12-12-30.
//  Copyright (c) 2012年 CL7RNEC. All rights reserved.
//

#import "WordView.h"

@implementation WordView

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
 }iew *tableView;
*/
-(void)dealloc{
    [_tableView release];
    [_btnMap release];
    [_segWord release];
    [_searWord release];
    [_btnOrder release];
    [_labWord release];
    [_labPhonetics release];
    [_labTranslation release];
    [_btnEmphasis release];
    [_viewHeader release];
    [super dealloc];
}
#pragma mark -
#pragma mark init
-(void)initView{
    [self setBackgroundColor:colorBackground];
    //表格
    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, 320, SCREEN_HEIGHT-110) style:UITableViewStylePlain];
    [_tableView setBackgroundColor:colorBackground];
    [self addSubview:_tableView];
    //地图按钮
    _btnMap=[UIButton buttonWithType:UIButtonTypeCustom];
    [_btnMap setFrame:CGRectMake(0, 0, 50, 50)];
    [_btnMap setBackgroundImage:imgMap forState:UIControlStateNormal];
    //单词类型按钮
    NSArray *arrName = [NSArray arrayWithObjects:NSLocalizedString(@"全部", nil),NSLocalizedString(@"重点", nil), nil];
    _segWord=[[UISegmentedControl alloc] initWithItems:arrName];
    [_segWord setSegmentedControlStyle:UISegmentedControlStyleBar];
    _segWord.frame=CGRectMake(0, 0, 100, 30);
    [_segWord setSelectedSegmentIndex:0];
    //表格header
    _viewHeader=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 40)];
    //搜索框
    _searWord=[[UISearchBar alloc]initWithFrame:CGRectMake(40, 0, 280, 40)];
    [_searWord setTintColor:colorBar];
    [_viewHeader addSubview:_searWord];
    //排序按钮
    _btnOrder=[UIButton buttonWithType:UIButtonTypeCustom];
    [_btnOrder setFrame:CGRectMake(0, 0, 40, 40)];
    [_btnOrder setBackgroundColor:colorSpeech];
    [_btnOrder setImage:imgDate forState:UIControlStateNormal];
    [_viewHeader addSubview:_btnOrder];
    [_tableView setTableHeaderView:_viewHeader];
    
}
-(void)initTableCellView:(UITableViewCell *)tableCell{
    //单词
    _labWord=[[UILabel alloc]initWithFrame:CGRectMake(50, 5, 150, 30)];
    [_labWord setBackgroundColor:colorLab];
    [_labWord setFont:[UIFont systemFontOfSize:15]];
    _labWord.tag=TAG_WORD;
    [tableCell.contentView addSubview:_labWord];
    //音标
    _labPhonetics=[[UILabel alloc]initWithFrame:CGRectMake(200, 5, 150, 30)];
    [_labPhonetics setBackgroundColor:colorLab];
    [_labPhonetics setFont:[UIFont systemFontOfSize:12]];
    _labPhonetics.tag=TAG_PHONETICS;
    [tableCell.contentView addSubview:_labPhonetics];
    //翻译
    _labTranslation=[[UILabel alloc]initWithFrame:CGRectMake(10, 40, 260, 30)];
    [_labTranslation setBackgroundColor:colorLab];
    [_labTranslation setFont:[UIFont systemFontOfSize:12]];
    _labTranslation.tag=TAG_TRANSLATION;
    [tableCell.contentView addSubview:_labTranslation];
    //是否重点
    _btnEmphasis=[UIButton buttonWithType:UIButtonTypeCustom];
    _btnEmphasis.tag=TAG_EMPHASIS;
    [_btnEmphasis setFrame:CGRectMake(10, 5, 30, 30)];
    [_btnEmphasis setBackgroundImage:imgEmphasisNo forState:UIControlStateNormal];
    [tableCell.contentView addSubview:_btnEmphasis];
}
@end
