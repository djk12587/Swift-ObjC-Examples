//
//  CatViewControllerParent.m
//  Swift&ObjC
//
//  Created by Daniel Koza on 8/7/14.
//  Copyright (c) 2014 Allstate R&D. All rights reserved.
//

#import "CatViewControllerParent.h"

@interface CatViewControllerParent ()

@end

@implementation CatViewControllerParent

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    [self.myLabel setPreferredMaxLayoutWidth:screenWidth - (17 * 2)];
    
    [self setTitle:@"Cat Facts!"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
