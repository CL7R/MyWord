//
//  WordController.m
//  MyWord
//
//  Created by CL7RNEC on 12-12-30.
//  Copyright (c) 2012年 CL7RNEC. All rights reserved.
//

#import "WordController.h"
#import "WordView.h"
#import "DataDao.h"
#import "MyWords.h"
#import "WordDetailController.h"
#import "WordMapController.h"
#import "PublicDate.h"
@interface WordController ()

@end

int updataFlag;

@implementation WordController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated{
    //是否更新过单词
    CLog(@"\n[viewWillAppear]%d,%d",updataFlag,_initFlag);
    if (updataFlag==UPDATE_YES&&_initFlag==INIT_YES) {
        _arrWords=[_data queryWord:@"" queryType:QUERY_INIT];
        [_arrWords retain];
        //数据转换
        [self wordsToKV];
        [_wordView.tableView reloadData];
        //设置偏移值，隐藏搜索框
        [_wordView.tableView setContentOffset:CGPointMake(0, 40) animated:NO];
        updataFlag=UPDATE_NO;
    }
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
    [_wordView release];
    [_arrWords release];
    [_muarrWords release];
    [super dealloc];
}
#pragma mark - init
-(void)initData{
    _initFlag=INIT_YES;
    _arrWords=[[NSArray alloc]init];
    _orderFlag=QUERY_ORDER_WORD;
    _data=[DataDao getInstance];
    [self.navigationController.navigationBar setTintColor:colorNavBar];
    //初始化视图
    _wordView=[[WordView alloc]initWithFrame:CGRectMake(0, 0, 320, SCREEN_HEIGHT)];
    [_wordView.tableView setScrollEnabled:YES];
    _wordView.tableView.delegate=self;
    _wordView.tableView.dataSource=self;
    //地图
    UIBarButtonItem *rightBar=[[UIBarButtonItem alloc]initWithCustomView:_wordView.btnMap];
    [_wordView.btnMap addTarget:self action:@selector(actionMap:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem=rightBar;
    [rightBar release];
    //单词类型
    self.navigationItem.titleView=_wordView.segWord;
    [_wordView.segWord addTarget:self action:@selector(actionWordType:) forControlEvents:UIControlEventValueChanged];
    //搜索
    _wordView.searWord.delegate=(id)self;
    //排序
    [_wordView.btnOrder addTarget:self action:@selector(actionWordOrder:) forControlEvents:UIControlEventTouchUpInside];
    
    self.view=_wordView;
    //获取数据
    _arrWords=[_data queryWord:@"" queryType:QUERY_INIT];
    [_arrWords retain];
    //数据转换
    [self wordsToKV];
    //重载table
    [_wordView.tableView reloadData];
    //设置偏移值，隐藏搜索框
    [_wordView.tableView setContentOffset:CGPointMake(0, 40) animated:NO];
}
#pragma mark - other
-(void)wordsToKV{
    _muarrWords=[[NSMutableArray alloc]init];
    int index=1;
    NSString *indexSection=@"";
    NSString *indexOrder=@"";
    NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];
    NSMutableArray *arr=[[NSMutableArray alloc]init];
    for (MyWords *word in _arrWords) {
        //区分名称和日期
        if (_orderFlag==QUERY_ORDER_WORD) {
            indexOrder=word.wordIndex;
        }
        else{
            indexOrder=[PublicDate dateToTime:word.modifyDate dateType:1];
        }
        if (![indexSection isEqualToString:indexOrder]) {
            //不是第一次，需要将上一次的数组放入字典，再将数组放入字典
            if (![indexSection isEqualToString:@""]) {
                [dic setObject:arr forKey:@"words"];
                [_muarrWords addObject:dic];
                //清空数组和字典
                [arr release];
                [dic release];
                dic=[[NSMutableDictionary alloc]init];
                arr=[[NSMutableArray alloc]init];
            }
            //将索引放入字典
            indexSection=indexOrder;
            [dic setObject:indexSection forKey:@"wordIndex"];
            [arr addObject:word];
        }
        else{
            [arr addObject:word];
        }
        ++index;
    }
    //保存最后一条数据，且数组不为空
    if ([_arrWords count]>0) {
        [dic setObject:arr forKey:@"words"];
        [_muarrWords addObject:dic];
    }
    [arr release];
    [dic release];
}
#pragma mark - action
-(void)actionWordType:(id)sender{
    UISegmentedControl *seg=(UISegmentedControl *)sender;
    CLog(@"\n[actionWordType]%d",seg.selectedSegmentIndex);
    /*if (seg.selectedSegmentIndex==0) {
        _arrWords=[_data queryWord:@"0" queryType:QUERY_SEARCH_EMPHASIS];
        [_arrWords retain];
        //数据转换
        [self wordsToKV];
        [_wordView.tableView reloadData];
    }
    else{
        _arrWords=[_data queryWord:@"1" queryType:QUERY_SEARCH_EMPHASIS];
        [_arrWords retain];
        //数据转换
        [self wordsToKV];
        [_wordView.tableView reloadData];
    }*/
    _arrWords=[_data queryWord:[NSString stringWithFormat:@"%d",seg.selectedSegmentIndex] queryType:QUERY_SEARCH_EMPHASIS];
    [_arrWords retain];
    //数据转换
    [self wordsToKV];
    [_wordView.tableView reloadData];
    //设置偏移值，隐藏搜索框
    [_wordView.tableView setContentOffset:CGPointMake(0, 40) animated:NO];
}
-(void)actionMap:(id)sender{
    WordMapController *map=[[[WordMapController alloc]init]autorelease];
    map.arrWord=_arrWords;
    [self.navigationController pushViewController:map animated:YES];
}
-(void)actionWordOrder:(id)sender{
    UIButton *btn=(UIButton *)sender;
    if (_orderFlag==QUERY_ORDER_WORD) {
        _arrWords=[_data queryWord:@"" queryType:QUERY_ORDER_DATE];
        _orderFlag=QUERY_ORDER_DATE;
        [btn setImage:imgAlp forState:UIControlStateNormal];
    }
    else{
        _arrWords=[_data queryWord:@"" queryType:QUERY_ORDER_WORD];
        _orderFlag=QUERY_ORDER_WORD;
        [btn setImage:imgDate forState:UIControlStateNormal];
    }
    [_arrWords retain];
    //数据转换
    [self wordsToKV];
    [_wordView.tableView reloadData];
}
-(void)actionWordEmphasis:(id)sender{
    UITableViewCell * cell = (UITableViewCell *)[[sender superview] superview];
    NSIndexPath * indexPath = [_wordView.tableView indexPathForCell:cell];
    int section=[indexPath section];
    int row=[indexPath row];
    NSArray *arr=[[_muarrWords objectAtIndex:section] objectForKey:@"words"];
    MyWords *word=(MyWords *)[arr objectAtIndex:row];
    DataDao *data=[DataDao getInstance];
    UIButton *btn=(UIButton *)[cell viewWithTag:TAG_EMPHASIS];
    if ([word.isEmphasis intValue]==1) {
        word.isEmphasis=[NSNumber numberWithInt:0];
        [btn setBackgroundImage:imgEmphasisNo forState:UIControlStateNormal];
    }
    else{
        word.isEmphasis=[NSNumber numberWithInt:1];
        [btn setBackgroundImage:imgEmphasisYes forState:UIControlStateNormal];
    }
    [data updateWord:word];
}
#pragma mark - Table view data source
//分区数量
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [_muarrWords count];
}
//分区名称
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [[_muarrWords objectAtIndex:section]objectForKey:@"wordIndex"];
}
//每个分区的数据行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    CLog(@"\n[numberOfRowsInSection]%d",[[[_muarrWords objectAtIndex:section] objectForKey:@"words"]count]);
    return [[[_muarrWords objectAtIndex:section] objectForKey:@"words"]count];
}
//索引名称
- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    if (_orderFlag==QUERY_ORDER_WORD) {
        if (_isSearch==SEARCH_NO) {
            return [_muarrWords valueForKey:@"wordIndex"];
        }
        else{
            return nil;
        }
    }
    else{
        return nil;
    }
}
//每个cell的高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return TABLE_CELL_HEIGH;
}
//绘制cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CLog(@"\n[cellForRowAtIndexPath-1]%d",[indexPath row]);
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                       reuseIdentifier:CellIdentifier] autorelease];
        [_wordView initTableCellView:cell];
    }
    int section=[indexPath section];
    int row=[indexPath row];
    NSArray *arr=[[_muarrWords objectAtIndex:section] objectForKey:@"words"];
    
    MyWords *word=(MyWords *)[arr objectAtIndex:row];
    CLog(@"\n[cellForRowAtIndexPath-2]%@",word.isEmphasis);
    UILabel *lab1=(UILabel *)[cell viewWithTag:TAG_WORD];
    lab1.text=word.word;
    UILabel *lab2=(UILabel *)[cell viewWithTag:TAG_PHONETICS];
    lab2.text=word.phonetics;
    UILabel *lab3=(UILabel *)[cell viewWithTag:TAG_TRANSLATION];
    lab3.text=word.translation;
    UIButton *btn=(UIButton *)[cell viewWithTag:TAG_EMPHASIS];
    //根据单词长度动态显示与音标的位置
    UIFont *font = [UIFont systemFontOfSize:15];
	CGSize size = [lab1.text sizeWithFont:font constrainedToSize:CGSizeMake(150.0f, 1000.0f) lineBreakMode:UILineBreakModeCharacterWrap];
    CGRect frame =lab1.frame;
    lab1.frame=CGRectMake(frame.origin.x, frame.origin.y, size.width, frame.size.height);
    frame =lab2.frame;
    lab2.frame=CGRectMake(size.width+60, frame.origin.y, frame.size.width, frame.size.height);
    //判断是否是重点
    if ([word.isEmphasis intValue]==1) {        
        [btn setBackgroundImage:imgEmphasisYes forState:UIControlStateNormal];
    }
    else{
        [btn setBackgroundImage:imgEmphasisNo forState:UIControlStateNormal];
    }
    //是否重点
    [btn addTarget:self action:@selector(actionWordEmphasis:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}

#pragma mark - Table view delegate
//点击cell触发事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CLog(@"\n[didSelectRowAtIndexPath-1]");
    int section=[indexPath section];
    int row=[indexPath row];
    NSArray *arr=[[_muarrWords objectAtIndex:section] objectForKey:@"words"];
    MyWords *word=(MyWords *)[arr objectAtIndex:row];
    WordDetailController *detail=[[[WordDetailController alloc]init]autorelease];
    detail.word=word;
    CLog(@"\n[didSelectRowAtIndexPath-2]%@",word.browseCount);    
    detail.wordCon=self;
    [self.navigationController pushViewController:detail animated:YES];
}
//删除信息
-(void)tableView:(UITableView *)tableView
commitEditingStyle:(UITableViewCellEditingStyle)editingStyle
forRowAtIndexPath:(NSIndexPath *)indexPath{
    int section=[indexPath section];
    int row=[indexPath row];
    NSMutableArray *arr=[[_muarrWords objectAtIndex:section]objectForKey:@"words"];
    if (row<[arr count]) {
        MyWords *word=[arr objectAtIndex:row];
        [_data deleteWord:word];
        [arr removeObjectAtIndex:row];
        if ([arr count]==0) {
            [_muarrWords removeObjectAtIndex:section];
            [tableView deleteSections:[NSIndexSet indexSetWithIndex:indexPath.section]
                     withRowAnimation:UITableViewRowAnimationFade];
        }
        else{
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
        }
    }
}
#pragma mark - searchBar delegate
//取消按钮
-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    //取消
    [searchBar setText:@""];
    [searchBar resignFirstResponder];
}
//搜索按钮
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    _arrWords=[_data queryWord:searchBar.text queryType:QUERY_SEARCH_ALL];
    [_arrWords retain];
    //数据转换
    [self wordsToKV];
    [_wordView.tableView reloadData];
    [searchBar resignFirstResponder];
}
//搜索框文字改变
-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    _arrWords=[_data queryWord:searchText queryType:QUERY_SEARCH_ALL];
    [_arrWords retain];
    //数据转换
    [self wordsToKV];
    [_wordView.tableView reloadData];
}
//触发搜索
-(void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
    _isSearch=SEARCH_YES;
    [searchBar setShowsCancelButton:YES animated:YES];
    [_wordView.tableView reloadData];
}
//结束搜索
-(void)searchBarTextDidEndEditing:(UISearchBar *)searchBar{
    [_wordView.btnOrder setHidden:NO];
    [searchBar setShowsCancelButton:NO animated:YES];
    _isSearch=SEARCH_NO;
    [_wordView.tableView reloadData];
}
@end
