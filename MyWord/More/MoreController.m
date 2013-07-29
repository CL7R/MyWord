//
//  MoreController.m
//  MyWord
//
//  Created by CL7RNEC on 12-12-30.
//  Copyright (c) 2012年 CL7RNEC. All rights reserved.
//

#import "MoreController.h"
#import "DataDao.h"
#import "DefaultFileDataManager.h"
#import "AboutMeController.h"
@interface MoreController ()

@end

int updataFlag;

@implementation MoreController

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
    [self initView];
    [self initData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc{
    [_dicMore release];
    [_arrMore release];
    [super dealloc];
}
#pragma mark - init
-(void)initView{
    [self.navigationController.navigationBar setTintColor:colorNavBar];
    UITableView *table=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, 320, SCREEN_HEIGHT) style:UITableViewStyleGrouped];
    [table setBackgroundColor:colorBackground];
    table.delegate=(id)self;
    table.dataSource=(id)self;
    [self.view addSubview:table];
    [table release];    
}
-(void)initData{
    self.navigationItem.title=NSLocalizedString(@"更多", nil);
    NSString *path=[[NSBundle mainBundle]pathForResource:@"more" ofType:@"plist"];
    _dicMore=[[NSDictionary alloc]initWithContentsOfFile:path];
    _arrMore=[[_dicMore allKeys]sortedArrayUsingSelector:@selector(compare:)];
    [_arrMore retain];
    [DefaultFileDataManager getFileData:DATA_FILE];
}
#pragma mark - action
-(void)actionOpenKeyboard:(id)sender{
    UISegmentedControl *seg=(UISegmentedControl *)sender;
    [DefaultFileDataManager getFileData:DATA_FILE];
    if (seg.selectedSegmentIndex==0) {
        [dicFileData setObject:[NSNumber numberWithInt:OPEN_KEYBOARD_YES] forKey:@"openKeyboard"];
    }
    else{
        [dicFileData setObject:[NSNumber numberWithInt:OPEN_KEYBOARD_NO] forKey:@"openKeyboard"];
    }
    [DefaultFileDataManager saveFile];
}
#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [_arrMore count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSString *key=[_arrMore objectAtIndex:section];
    NSArray *arr=[_dicMore objectForKey:key];
    return [arr count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        NSUInteger section=[indexPath section];
        NSUInteger row=[indexPath row];
        NSString *key=[_arrMore objectAtIndex:section];
        NSArray *arr=[_dicMore objectForKey:key];
        
        //增加默认启动键盘设置
        [DefaultFileDataManager getFileData:DATA_FILE];
        if([[arr objectAtIndex:row] isEqualToString:@"默认弹出键盘"]){
            NSArray *arrName = [NSArray arrayWithObjects:NSLocalizedString(@"开启", nil),NSLocalizedString(@"关闭", nil), nil];
            UISegmentedControl *seg=[[UISegmentedControl alloc] initWithItems:arrName];
            [seg setSegmentedControlStyle:UISegmentedControlStyleBar];
            [seg setTintColor:colorNavBar];
            
            seg.frame=CGRectMake(170, 7, 100, 30);
            if ([dicFileData objectForKey:@"openKeyboard"]) {
                if ([[dicFileData objectForKey:@"openKeyboard"] intValue]==OPEN_KEYBOARD_YES){
                    [seg setSelectedSegmentIndex:0];
                }
                else{
                    [seg setSelectedSegmentIndex:1];
                }
            }
            else{
                [seg setSelectedSegmentIndex:0];
            }
            [seg addTarget:self action:@selector(actionOpenKeyboard:) forControlEvents:UIControlEventValueChanged];
            cell.textLabel.text=[arr objectAtIndex:row];
            [cell.contentView addSubview:seg];
            [seg release];
            cell.selectedBackgroundView.backgroundColor = [UIColor clearColor];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        else{
            cell.textLabel.text=[arr objectAtIndex:row];
        }
        
    }
    
    return cell;
}

#pragma mark - Table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSUInteger section=[indexPath section];
    NSUInteger row=[indexPath row];
    NSString *key=[_arrMore objectAtIndex:section];
    NSArray *arr=[_dicMore objectForKey:key];
    if([[arr objectAtIndex:row] isEqualToString:@"清空我的单词"]){
        UIAlertView *alert=[[[UIAlertView alloc]initWithTitle:NSLocalizedString(@"清空单词", nil) message:NSLocalizedString(@"您是否要清空所有收藏单词？", nil) delegate:self cancelButtonTitle:NSLocalizedString(@"清空", nil) otherButtonTitles:NSLocalizedString(@"取消", nil), nil]autorelease];
        [alert show];
    }
    else if([[arr objectAtIndex:row] isEqualToString:@"默认弹出键盘"]){
        
    }
    else{
        AboutMeController *about=[[[AboutMeController alloc]init]autorelease];
        [self.navigationController pushViewController:about animated:YES];
    }
}
#pragma mark alertDelegate
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{    
    if (buttonIndex==0) {
        DataDao *data=[DataDao getInstance];
        [data deleteAllWords];
        updataFlag=UPDATE_YES;
    }
}
@end
