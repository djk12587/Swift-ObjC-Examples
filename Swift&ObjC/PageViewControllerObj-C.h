//
//  PageViewControllerObj-C.h
//  Swift&ObjC
//
//  Created by Daniel Koza on 8/5/14.
//  Copyright (c) 2014 Allstate R&D. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PageViewControllerObj_C : UIViewController <UIPageViewControllerDataSource>

@property (strong, nonatomic) UIPageViewController *pageController;

@end
