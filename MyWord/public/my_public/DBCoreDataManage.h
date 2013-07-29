//
//  DBCoreDataManage.h
//  MyWord
//  
//  Created by CL7RNEC on 12-12-30.
//  Copyright (c) 2012年 CL7RNEC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

#define EXPSQL_FILE     @"MyWord.sqlite"
#define MODEL_FILE      @"MyWord"

@interface DBCoreDataManage : NSObject{
    NSManagedObjectContext *managedObjectContext;
    NSManagedObjectModel *managedObjectModel;
    NSPersistentStoreCoordinator *persistentStoreCoordinator;
}

@property (nonatomic, retain, readonly) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain, readonly) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, retain, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;

/*
 desc:获取单例
 @parame:
 return:DBCoreDataManage
 */
+(DBCoreDataManage *)getInstance;
/*
 desc:返回该程序的档案目录，用来简单使用
 @parame:
 return:NSString
 */
- (NSString *)applicationDocumentsDirectory;
/*
 desc:保存coreData数据
 @parame:
 return:
 */
- (void)saveContext;
/*
 desc:清空coreData数据
 @parame:
 return:
 */
- (void)cleanDatabase;

@end
