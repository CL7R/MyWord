//
//  WordController.h
//  MyWord
//
//  Created by CL7RNEC on 12-12-30.
//  Copyright (c) 2012年 CL7RNEC. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum{
    INIT_YES=1,
    INIT_NO
}initEnum;

typedef enum{
    SEARCH_NO=0,
    SEARCH_YES
}searchEnum;

@class WordView;
@class DataDao;
@interface WordController : UIViewController<UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate>

@property (nonatomic,assign) int isSearch;          //是否正在搜索
@property (nonatomic,assign) int initFlag;          //是否初始化
@property (nonatomic,assign) int orderFlag;         //当前排序
@property (strong,nonatomic) WordView *wordView;
@property (strong,nonatomic) NSArray *arrWords;
@property (strong,nonatomic) NSMutableArray *muarrWords;
@property (strong,nonatomic) DataDao *data;

-(void)initData;
/*
 desc:单词数组转成键值关系
 @parame
 return:
 */
-(void)wordsToKV;
/*
 desc:选择单词类型
 @parame
 return:
 */
-(void)actionWordType:(id)sender;
/*
 desc:地图
 @parame
 return:
 */
-(void)actionMap:(id)sender;
/*
 desc:排序
 @parame
 return:
 */
-(void)actionWordOrder:(id)sender;
/*
 desc:标记重点
 @parame
 return:
 */
-(void)actionWordEmphasis:(id)sender;
@end
