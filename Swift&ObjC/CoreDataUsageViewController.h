//
//  CoreDataUsageViewController.h
//  Swift&ObjC
//
//  Created by Daniel Koza on 8/18/14.
//  Copyright (c) 2014 Allstate R&D. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CoreDataUsageViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UIButton *addARecordButton;
@property (weak, nonatomic) IBOutlet UIButton *deleteAllButton;
@property (weak, nonatomic) IBOutlet UITableView *coreDataTableView;
@property (nonatomic, strong) NSMutableArray *resultsArray;

@end
