//
//  MyWords.h
//  MyWord
//
//  Created by CL7RNEC on 12-12-30.
//  Copyright (c) 2012年 CL7RNEC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface MyWords : NSManagedObject

@property (nonatomic, retain) NSNumber * id;
@property (nonatomic, retain) NSNumber * cateId;
@property (nonatomic, retain) NSString * word;
@property (nonatomic, retain) NSString * wordIndex;
@property (nonatomic, retain) NSString * phonetics;
@property (nonatomic, retain) NSString * voice;
@property (nonatomic, retain) NSString * translation;
@property (nonatomic, retain) NSString * mark;
@property (nonatomic, retain) NSDate * createDate;
@property (nonatomic, retain) NSDate * modifyDate;
@property (nonatomic, retain) NSNumber * isEmphasis;
@property (nonatomic, retain) NSNumber * isAlert;
@property (nonatomic, retain) NSNumber * latitude;
@property (nonatomic, retain) NSNumber * longitude;
@property (nonatomic, retain) NSNumber * browseCount;

@end
