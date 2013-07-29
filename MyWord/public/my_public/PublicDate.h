//
//  PublicDate.h
//  dbc
//  日期类，涉及到所有和日期操作有关的类
//  Created by CL7RNEC on 12-4-9.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PublicDate : NSObject
/*
 desc：计算指定时间和当前时间的差距
 @param:paramDateTime：指定时间，格式@"yyyy-MM-dd HH:mm:ss"
 return:NSDateComponents
 */
+(NSDateComponents *)calculationDateTime:(NSString *)paramDateTime;
/*
 desc：计算指定时间之间的差距
 @param:paramDateTimeTo：指定结束时间，格式@"yyyy-MM-dd HH:mm:ss"
 @param:paramDateTimeFrom：指定开始时间，格式@"yyyy-MM-dd HH:mm:ss"
 return:NSDateComponents
 */
+(NSDateComponents *)calculationDateTime:(NSString *)paramDateTimeTo
                      parameDateTimeFrom:(NSString *)paramDateTimeFrom;
/*
 desc：将日期转换为字符串
 @param:paramDate：日期
 @param:parameType：时间格式
 return:NSString
 */
+(NSString *)dateToTime:(NSDate *)paramDate
               dateType:(int)paramType;
/*
 desc：将字符串转换为日期
 @param:paramString：字符类型的日期
 @param:parameType：格式
 return:NSDate
 */
+(NSDate *)TimeTodate:(NSString *)paramString
             dateType:(int)paramType;
/*
 desc：获取当前日期
 @param:parameType：格式
 return:NSString
 */
+(NSString *)getCurrentDate:(int)paramType;
/*
 desc：去掉毫秒
 @param:paramString：时间
 return:NSString
 */
+(NSString *)cancelMillisecond:(NSString *)paramString;
@end
