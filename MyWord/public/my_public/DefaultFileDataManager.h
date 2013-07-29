//
//  DefaultFileDataManager.h
//  MyWord
//
//  Created by CL7RNEC on 13-1-1.
//  Copyright (c) 2013年 CL7RNEC. All rights reserved.
//

#import <Foundation/Foundation.h>

#define DATA_FILE   @"dataFile.plist"   //保存路径
NSString *filePath;                     //文件路径
NSMutableDictionary *dicFileData;       //保存对象
@interface DefaultFileDataManager : NSObject

/*
 desc：获取数据
 @parame:fileName：文件名称
 return:
 */
+(void)getFileData:(NSString *)fileName;
/*
 desc：保存文件
 parame：
 return：
 */
+(void)saveFile;
@end
