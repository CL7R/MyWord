//
//  DBCoreDataManage.m
//  MyWord
//
//  Created by CL7RNEC on 12-12-30.
//  Copyright (c) 2012年 CL7RNEC. All rights reserved.
//

#import "DBCoreDataManage.h"

@implementation DBCoreDataManage

- (void)dealloc {
    
    [managedObjectContext release];
    [managedObjectModel release];
    [persistentStoreCoordinator release];
    [super dealloc];
}
#pragma mark -
#pragma mark init
+(DBCoreDataManage *)getInstance{
    static DBCoreDataManage *db;
    if(db==nil){
        db=[[DBCoreDataManage alloc]init];
    }
    return db;
}
#pragma mark -
#pragma mark other
//返回该程序的档案目录，用来简单使用
- (NSString *)applicationDocumentsDirectory {
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    NSString *basePath = ([paths count] > 0) ? [paths objectAtIndex:0] : nil;
    return basePath;
}
- (void)saveContext {
    
    NSError *error = nil;	
    if (managedObjectContext != nil) {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            /*
             Replace this implementation with code to handle the error appropriately.
             
             abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. If it is not possible to recover from the error, display an alert panel that instructs the user to quit the application by pressing the Home button.
             */
            NSLog(@"\n[Unresolved error]%@, %@", error, [error userInfo]);
            abort();
        }
    }
}
- (void)cleanDatabase{
    NSArray *stores = [persistentStoreCoordinator persistentStores];    
    for(NSPersistentStore *store in stores) {
        [persistentStoreCoordinator removePersistentStore:store error:nil];
        [[NSFileManager defaultManager] removeItemAtPath:store.URL.path error:nil];
    }
    [persistentStoreCoordinator release];
    persistentStoreCoordinator = nil;
    [managedObjectContext release];
    managedObjectContext=nil;
    [managedObjectModel release];
    managedObjectModel=nil;
}
#pragma mark -
#pragma mark Core Data
//自定义的managedObjectContext的getter, 它其实是真正在使用的时候的被操作对象
- (NSManagedObjectContext *) managedObjectContext {
    
    //如果已经有这个对象，就直接返回，否则继续
    if (managedObjectContext != nil) {
        return managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        managedObjectContext = [[NSManagedObjectContext alloc] init];
        [managedObjectContext setPersistentStoreCoordinator: coordinator];
        //这里可以看到，“内容管理器”和“数据一致性存储器”的关系，
        //managedObjectContext需要得到这个“数据一致性存储器”
    }
    return managedObjectContext;
}

//自定义的CoreData数据模板的getter，数据模板其实就是一个描述实体与实体的关系，类似于关系型数据库的关系描述文件
- (NSManagedObjectModel *)managedObjectModel {
    
    if (managedObjectModel != nil) {
        return managedObjectModel;
    }
    //从本地所有xcdatamodel文件得到这个CoreData数据模板
    //managedObjectModel = [[NSManagedObjectModel mergedModelFromBundles:nil] retain];
    //搜索指定文件
    NSString *modelPath = [[NSBundle mainBundle] pathForResource:MODEL_FILE ofType:@"momd"];
    NSURL *modelURL = [NSURL fileURLWithPath:modelPath];
    managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return managedObjectModel;
}

//自定义“数据一致性存储器” persistentStoreCoordinator的getter
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    
    if (persistentStoreCoordinator != nil) {
        return persistentStoreCoordinator;
    }
    
    //定义一个本地地址到NSURL，用来存储那个SQLite文件
    NSURL *storeUrl = [NSURL fileURLWithPath:
                       [[self applicationDocumentsDirectory]
                        stringByAppendingPathComponent:EXPSQL_FILE]];
    
    NSError *error;
    persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc]
                                  initWithManagedObjectModel: [self managedObjectModel]];
    //从这里可以看出，其实persistentStoreCoordinator需要的不过是一个存储数据的位置，它是负责管理CoreData如何储存数据的
    if (![persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType
          configuration:nil
          URL:storeUrl
          options:nil
          error:&error]) {
    }
    
    return persistentStoreCoordinator;
}
@end
