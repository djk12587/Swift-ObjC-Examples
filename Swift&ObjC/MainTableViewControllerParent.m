//
//  MainTableViewControllerParent.m
//  Swift&ObjC
//
//  Created by Daniel Koza on 8/6/14.
//  Copyright (c) 2014 Allstate R&D. All rights reserved.
//

#import "MainTableViewControllerParent.h"
#import "CoreDataHelper.h"
#import "ExampleEntityObjC.h"
#import "CoreDataHelper.h"
#import "NSManagedObject+Creation.h"
#import "NSManagedObject+Fetch.h"
#import "CoreDataHelper+Saver.h"

@interface MainTableViewControllerParent ()

@end

@implementation MainTableViewControllerParent

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return 0;
}

@end
