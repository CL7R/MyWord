//
//  AboutMeController.m
//  MyWord
//
//  Created by CL7RNEC on 13-1-8.
//  Copyright (c) 2013年 CL7RNEC. All rights reserved.
//

#import "AboutMeController.h"
#import "AboutMeView.h"
@interface AboutMeController ()

@end

@implementation AboutMeController

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
    _aboutView=[[AboutMeView alloc]initWithFrame:CGRectMake(0, 0, 320, SCREEN_HEIGHT)];
    self.view=_aboutView;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
