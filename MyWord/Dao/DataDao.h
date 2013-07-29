//
//  DataDao.h
//  MyWord
//
//  Created by CL7RNEC on 12-12-30.
//  Copyright (c) 2012年 CL7RNEC. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum{
    COREDATA_SUCCES=1,
    COREDATA_REPEAT,
    COREDATA_ERROR
}coreDataFlag;

typedef enum{
    QUERY_INIT=1,
    QUERY_SEARCH_ALL,
    QUERY_SEARCH_WORD,
    QUERY_SEARCH_EMPHASIS,
    QUERY_ORDER_WORD,
    QUERY_ORDER_DATE
}queryFlag;

@class MyWords;
@class Category;

@interface DataDao : NSObject

@property(nonatomic,assign) int orderFlag;
@property(strong,nonatomic) NSManagedObjectContext *context;
/*
 desc:获取单例
 @parame:
 return:DataDao
 */
+(DataDao *)getInstance;

-(void)initData;
/*
 desc:插入类别
 @parame:dicCategory:category实体信息
 return:BOOL
 */
-(int)insertCategory:(NSDictionary *)dicCategory;
/*
 desc:插入单词
 @parame:dicWord:word实体信息
 return:BOOL
 */
-(int)insertWord:(NSDictionary *)dicWord;
/*
 desc:删除单词
 @parame:
 return:BOOL
 */
-(BOOL)deleteWord:(MyWords *)word;
/*
 desc:删除全部单词
 @parame:
 return:BOOL
 */
-(BOOL)deleteAllWords;
/*
 desc:修改单词
 @parame:
 return:BOOL
 */
-(BOOL)updateWord:(MyWords *)word;
/*
 desc:查询单词
 @parame:
 return:NSArray
 */
-(NSArray *)queryWord:(NSString *)word
            queryType:(int)queryType;
@end
