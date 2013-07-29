//
//  WordView.h
//  MyWord
//
//  Created by CL7RNEC on 12-12-30.
//  Copyright (c) 2012年 CL7RNEC. All rights reserved.
//

#import <UIKit/UIKit.h>

#define TABLE_CELL_HEIGH    75
#define TAG_EMPHASIS_ID     50
typedef enum{
    TAG_WORD=10,
    TAG_PHONETICS,
    TAG_TRANSLATION,
    TAG_EMPHASIS
}tagView;

@interface WordView : UIView

@property (strong,nonatomic) UITableView *tableView;
@property (strong,nonatomic) UIButton *btnMap;              //地图
@property (strong,nonatomic) UISegmentedControl *segWord;   //单词类型切换
@property (strong,nonatomic) UISearchBar *searWord;         //搜索框
@property (strong,nonatomic) UIButton *btnOrder;            //排序
@property (strong,nonatomic) UILabel *labWord;              //单词
@property (strong,nonatomic) UILabel *labPhonetics;         //音标
@property (strong,nonatomic) UILabel *labTranslation;       //翻译
@property (strong,nonatomic) UIButton *btnEmphasis;         //是否重点
@property (strong,nonatomic) UIView *viewHeader;            //表格的header

-(void)initView;
-(void)initTableCellView:(UITableViewCell *)tableCell;

@end
