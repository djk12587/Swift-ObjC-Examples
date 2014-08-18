//
//  CoreDataUsageViewController.m
//  Swift&ObjC
//
//  Created by Daniel Koza on 8/18/14.
//  Copyright (c) 2014 Allstate R&D. All rights reserved.
//

#import "CoreDataUsageViewController.h"
#import "ExampleEntityObjC.h"
#import "Swift_ObjC-Swift.h"

@interface CoreDataUsageViewController ()

@end

@implementation CoreDataUsageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setTitle:@"Core Data"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_resultsArray count];
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *simpleTableIdentifier = @"CoreDataTableCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    
    id coreDataEntity = _resultsArray[indexPath.row];
    
    if ([coreDataEntity isKindOfClass:[ExampleEntityObjC class]]) {
        NSString *dateString = [NSDateFormatter localizedStringFromDate:[(ExampleEntityObjC *)coreDataEntity date]
                                                              dateStyle:NSDateFormatterShortStyle
                                                              timeStyle:NSDateFormatterLongStyle];
        [cell.textLabel setText:dateString];
    } else {
        NSString *dateString = [NSDateFormatter localizedStringFromDate:[(ExampleEntitySwift *)coreDataEntity date]
                                                              dateStyle:NSDateFormatterShortStyle
                                                              timeStyle:NSDateFormatterLongStyle];
        [cell.textLabel setText:dateString];
    }
    
    return  cell;
}

@end
