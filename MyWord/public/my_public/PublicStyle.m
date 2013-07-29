//
//  PublicStyle.m
//  dbc
//  涉及到
//  Created by CL7RNEC on 12-4-9.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "PublicStyle.h"
//整体
UIImage *imgBarTran;
UIImage *imgBarWord;
UIImage *imgBarMore;
UIColor *colorBackground;
UIColor *colorNavBar;
//翻译
UIColor *colorBar;
UIImage *imgSpeech;
UIImage *imgSave;
UIColor *colorSpeech;
UIColor *colorBorder;
UIColor *colorShadow;
UIColor *colorLab;
UIImage *imgPicture;
UIImage *imgPictureFrame;
//我的单词
UIImage *imgMap;
UIImage *imgAll;
UIImage *imgEmphasisNo;
UIImage *imgEmphasisYes;
UIImage *imgAlp;
UIImage *imgDate;
UIImage *imgUpdate;
UIImage *imgBrowse;
UIImage *imgMyLocation;
UIImage *imgZoomIn;
UIImage *imgZoomOut;
@implementation PublicStyle
//初始化样式
+(void)initStyle:(int)styleFlag{
    if (styleFlag==STYLE_1) {
        //整体
        imgBarTran=[UIImage imageNamed:@"barTran"];
        [imgBarTran retain];
        imgBarWord=[UIImage imageNamed:@"barWord"];
        [imgBarWord retain];
        imgBarMore=[UIImage imageNamed:@"barMore"];
        [imgBarMore retain];
        colorBackground=RGB(246, 246, 246);
        [colorBackground retain];
        colorNavBar=RGB(52, 126, 223);
        [colorNavBar retain];
        colorBar=RGB(52, 126, 223);
        [colorBar retain];
        //翻译
        imgSpeech=[UIImage imageNamed:@"btnSpeech"];
        [imgSpeech retain];
        imgSave=[UIImage imageNamed:@"btnAuthCode"];
        [imgSave retain];
        imgPicture=[UIImage imageNamed:@"btnSpeech"];
        [imgPicture retain];
        imgPictureFrame=[UIImage imageNamed:@"ocrFrame"];
        [imgPictureFrame retain];
        colorSpeech=RGB(211, 211, 211);
        [colorSpeech retain];
        colorBorder=RGB(223, 223, 223);
        [colorBorder retain];
        colorShadow=RGB(183, 183, 183);
        [colorShadow retain];
        colorLab=RGB(246, 246, 246);
        [colorLab retain];
        //我的单词
        imgMap=[UIImage imageNamed:@"btnMap"];
        [imgMap retain];
        imgAll=[UIImage imageNamed:@"btnTest"];
        [imgAll retain];
        imgEmphasisNo=[UIImage imageNamed:@"btnEmphNo"];
        [imgEmphasisNo retain];
        imgEmphasisYes=[UIImage imageNamed:@"btnEmphYes"];
        [imgEmphasisYes retain];
        imgAlp=[UIImage imageNamed:@"btnLetter"];
        [imgAlp retain];
        imgDate=[UIImage imageNamed:@"btnDate"];
        [imgDate retain];
        imgUpdate=[UIImage imageNamed:@"btnTest"];
        [imgUpdate retain];
        imgBrowse=[UIImage imageNamed:@"imgFoot"];
        [imgBrowse retain];
        imgMyLocation=[UIImage imageNamed:@"btnMyLocation"];
        [imgMyLocation retain];
        imgZoomIn=[UIImage imageNamed:@"btnZoomIn"];
        [imgZoomIn retain];
        imgZoomOut=[UIImage imageNamed:@"btnZoomOut"];
        [imgZoomOut retain];
    }
    else if(styleFlag==STYLE_2){
        
    }
    else{
        
    }
}
@end
