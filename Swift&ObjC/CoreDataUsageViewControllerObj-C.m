//
//  CoreDataUsageViewControllerObj-C.m
//  Swift&ObjC
//
//  Created by Daniel Koza on 8/18/14.
//  Copyright (c) 2014 Allstate R&D. All rights reserved.
//

#import "CoreDataUsageViewControllerObj-C.h"
#import "CoreDataHelper.h"
#import "CoreDataHelper+Saver.h"
#import "NSManagedObject+Creation.h"
#import "NSManagedObject+Fetch.h"
#import "ExampleEntityObjC.h"

@interface CoreDataUsageViewControllerObj_C ()

@end

@implementation CoreDataUsageViewControllerObj_C

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.addARecordButton addTarget:self action:@selector(addARecord) forControlEvents:UIControlEventTouchUpInside];
    [self.deleteAllButton addTarget:self action:@selector(deleteAll) forControlEvents:UIControlEventTouchUpInside];
    
    NSArray *fetchResult = [ExampleEntityObjC core_findAllSortedBy:@"date" ascending:NO withPredicate:nil inContext:[CoreDataHelper privateQueueContext]];
    
    self.resultsArray = [[NSMutableArray alloc]initWithArray:fetchResult];
}

- (void) addARecord {
    __weak CoreDataUsageViewControllerObj_C *weakSelf = self;
    
    [CoreDataHelper core_saveInPrivateContext:^{
        
        ExampleEntityObjC *entity = [ExampleEntityObjC core_createInContext:[CoreDataHelper privateQueueContext]];
        [entity setDate:[NSDate date]];
        
        if (weakSelf) {
            [weakSelf.resultsArray insertObject:entity atIndex:0];
        }
        
        
    } completion:^(NSError *error) {
        if (error == nil && weakSelf != nil) {
            [weakSelf.coreDataTableView reloadData];
        }
    }];
}

- (void) deleteAll {
    __weak CoreDataUsageViewControllerObj_C *weakSelf = self;
    
    [CoreDataHelper core_saveInPrivateContext:^{
        
        if (weakSelf) {
            for (ExampleEntityObjC *entity in weakSelf.resultsArray) {
                [[CoreDataHelper privateQueueContext] deleteObject:entity];
            }
            [weakSelf.resultsArray removeAllObjects];
        }
        
    } completion:^(NSError *error) {
        if (error == nil && weakSelf) {
            [weakSelf.coreDataTableView reloadData];
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
