//
//  DataDao.m
//  MyWord
//
//  Created by CL7RNEC on 12-12-30.
//  Copyright (c) 2012年 CL7RNEC. All rights reserved.
//

#import "DataDao.h"
#import "DBCoreDataManage.h"
#import "DefaultFileDataManager.h"
#import "Category.h"
#import "MyWords.h"
@implementation DataDao

-(void)dealloc{
    [_context release];
    [super dealloc];
}
#pragma mark -
#pragma mark init
+(DataDao *)getInstance{
    static DataDao *dao=nil;
    if(dao==nil){
        dao=[[DataDao alloc]init];
    }
    return dao;
}
-(void)initData{
    _orderFlag=QUERY_ORDER_WORD;
    DBCoreDataManage *dbcore=[DBCoreDataManage getInstance];
    _context=[dbcore managedObjectContext];
    //如果初始化默认数据成功
    [DefaultFileDataManager getFileData:DATA_FILE];
    CLog(@"\n[initData]%@",dicFileData);
    if (![dicFileData objectForKey:@"coreData"]) {
        //初始化数据-类别表
        NSDictionary *dic=[NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInt:1],@"id",@"所有",@"name", nil];
        if([self insertCategory:dic]){
            [dicFileData setObject:@"1" forKey:@"coreData"];
            [DefaultFileDataManager saveFile];
        }
    }
}
#pragma mark -
#pragma mark other
-(int)insertCategory:(NSDictionary *)dicCategory{
    Category *cateDao =[NSEntityDescription insertNewObjectForEntityForName:@"Category"
                                                      inManagedObjectContext:_context];
    [cateDao setId:[dicCategory objectForKey:@"id"]];
    [cateDao setName:[dicCategory objectForKey:@"name"]];
    NSError *error = nil;
    if ([_context save:&error]) {
        CLog(@"\n[insertCategory-ok]");
	 	return COREDATA_SUCCES;
    }
    else{
        CLog(@"\n[insertCategory-error]%@", [error localizedDescription]);
        return COREDATA_ERROR;
    }
}
-(int)insertWord:(NSDictionary *)dicWord{
    //检查唯一性
    if ([[self queryWord:[dicWord objectForKey:@"word"] queryType:QUERY_SEARCH_WORD]count]==0) {
        MyWords *word=[NSEntityDescription insertNewObjectForEntityForName:@"MyWords"
                                                    inManagedObjectContext:_context];
        [word setId:[NSNumber numberWithInt:1]];
        [word setWord:[dicWord objectForKey:@"word"]];
        [word setPhonetics:[dicWord objectForKey:@"phonetics"]];
        [word setLatitude:[dicWord objectForKey:@"latitude"]];
        [word setLongitude:[dicWord objectForKey:@"longitude"]];
        [word setMark:[dicWord objectForKey:@"mark"]];
        [word setIsEmphasis:[dicWord objectForKey:@"isEmphasis"]];
        [word setTranslation:[dicWord objectForKey:@"translation"]];
        [word setBrowseCount:[dicWord objectForKey:@"browseCount"]];
        [word setCreateDate:[dicWord objectForKey:@"createDate"]];
        [word setModifyDate:[dicWord objectForKey:@"modifyDate"]];
        [word setWordIndex:[dicWord objectForKey:@"wordIndex"]];
        NSError *error = nil;
        if ([_context save:&error]) {
            CLog(@"\n[insertWord-ok]");
            return COREDATA_SUCCES;
        }
        else{
            CLog(@"\n[insertWord-error]%@", [error localizedDescription]);
            return COREDATA_ERROR;
        }
    }
    else{
        CLog(@"\n[insertWord-repeat]");
        return COREDATA_REPEAT;
    }
    
}
-(BOOL)deleteWord:(MyWords *)word{
    [_context deleteObject:word];
    NSError *error = nil;
    if ([_context save:&error]) {
        CLog(@"\n[deleteWord-ok]");
        return YES;
    }
    else{
        CLog(@"\n[deleteWord-error]%@", [error localizedDescription]);
        return NO;
    }
}
-(BOOL)deleteAllWords{
    //删除文件
    DBCoreDataManage *dbcore=[DBCoreDataManage getInstance];
    [dbcore cleanDatabase];
    //新建文件
    [self initData];
}
-(BOOL)updateWord:(MyWords *)word{
    NSError *error = nil;
    if ([_context save:&error]) {
        CLog(@"\n[updateWord-ok]");
        return YES;
    }
    else{
        CLog(@"\n[updateWord-error]%@", [error localizedDescription]);
        return NO;
    }
}
-(NSArray *)queryWord:(NSString *)word
            queryType:(int)queryType{
    NSFetchRequest *request = [[[NSFetchRequest alloc] init]autorelease];
    NSEntityDescription *ent = [NSEntityDescription entityForName:@"MyWords"
                                           inManagedObjectContext:_context];
    [request setEntity:ent];
    NSString *orderKey=[NSString stringWithFormat:@"word"];
    BOOL orderAsc=YES;
    switch (queryType) {
        case QUERY_SEARCH_ALL:{
            if ([word length]>0) {
                NSPredicate *pred = [NSPredicate predicateWithFormat:@"(word CONTAINS[cd] %@) OR (translation CONTAINS[cd] %@) OR (phonetics CONTAINS[cd] %@)",word,word,word];
                [request setPredicate:pred];
            }            
            break;
        }
        case QUERY_SEARCH_WORD:{
            NSPredicate *pred = [NSPredicate predicateWithFormat:@"word == %@",word];
            [request setPredicate:pred];
            break;
        }
        case QUERY_INIT:{
            
            break;
        }
        case QUERY_SEARCH_EMPHASIS:{
            if ([word intValue]==1) {
                NSPredicate *pred = [NSPredicate predicateWithFormat:@"isEmphasis == %d",[word intValue]];
                [request setPredicate:pred];
            }
            break;
        }
        case QUERY_ORDER_WORD:{
            orderKey=@"word";
            orderAsc=YES;
            break;
        }
        case QUERY_ORDER_DATE:{
            orderKey=@"modifyDate";
            orderAsc=NO;
            break;
        }
        default:
            break;
    }
    //排序
    NSSortDescriptor *sort = [[NSSortDescriptor alloc] initWithKey:orderKey ascending:orderAsc selector:@selector(localizedCaseInsensitiveCompare:)];
    NSArray *arrSort = [[NSArray alloc] initWithObjects:sort, nil];
    [request setSortDescriptors:arrSort];
    [sort release];
    [arrSort release];
    //执行
    NSArray *objects = [_context executeFetchRequest:request error:NULL];
    return objects;
}
@end
