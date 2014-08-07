//
//  CatViewControllerParent.h
//  Swift&ObjC
//
//  Created by Daniel Koza on 8/7/14.
//  Copyright (c) 2014 Allstate R&D. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CatViewControllerParent : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *myLabel;
@property (weak, nonatomic) IBOutlet UIImageView *myImageView;
@property (weak, nonatomic) IBOutlet UIButton *myRefreshButton;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *myActivityIndicator;

@end
