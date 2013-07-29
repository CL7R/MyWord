//
//  DefaultFileDataManager.m
//  MyWord
//
//  Created by CL7RNEC on 13-1-1.
//  Copyright (c) 2013年 CL7RNEC. All rights reserved.
//

#import "DefaultFileDataManager.h"

@implementation DefaultFileDataManager

+(void)getFileData:(NSString *)paramFile{
    @synchronized(self){
        NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                           NSUserDomainMask,
                                                           YES);
        NSString *documentsDirectory=[paths objectAtIndex:0];
        filePath =[documentsDirectory stringByAppendingPathComponent:paramFile];
        /*判断列表是否存在*/
        if ([[NSFileManager defaultManager]fileExistsAtPath:filePath]) {
            /*获取第一级字典*/
            dicFileData=[[[NSMutableDictionary alloc]
                          initWithContentsOfFile:filePath]autorelease];
        }
        else{
            dicFileData=[[[NSMutableDictionary alloc]init]autorelease];
        }
    }
}
/*保存文件*/
+(void)saveFile{
    @synchronized(self){
        [dicFileData writeToFile:filePath atomically:YES];
    }
}
@end
