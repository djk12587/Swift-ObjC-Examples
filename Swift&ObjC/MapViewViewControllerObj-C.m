//
//  MapViewViewControllerObj-C.m
//  Swift&ObjC
//
//  Created by Daniel Koza on 8/6/14.
//  Copyright (c) 2014 Allstate R&D. All rights reserved.
//

#import "MapViewViewControllerObj-C.h"

@interface MapViewViewControllerObj_C ()

@end

@implementation MapViewViewControllerObj_C

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _mySearchBar = [[UISearchBar alloc]init];
    [_mySearchBar setSearchBarStyle:UISearchBarStyleMinimal];
    [_mySearchBar setPlaceholder:@"Search for a Location"];
    [_mySearchBar setDelegate:self];
    [self.navigationItem setTitleView:_mySearchBar];
    
    [self.myResultsTableView setDelegate:self];
    [self.myResultsTableView setDataSource:self];
    [self.myResultsTableView setKeyboardDismissMode:UIScrollViewKeyboardDismissModeOnDrag];
    [self.myResultsTableView setBackgroundColor:[UIColor colorWithWhite:1.0f alpha:0.0]];
    [self.myResultsTableView setAlpha:0.0f];
    [self.myResultsTableView setContentInset:UIEdgeInsetsMake(64, 0, 0, 0)];
    
    UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    UIVisualEffectView *blurEffectView = [[UIVisualEffectView alloc]initWithEffect:blurEffect];
    [blurEffectView setFrame:self.myResultsTableView.bounds];
    
    [self.myResultsTableView setBackgroundView:blurEffectView];
    
    _resultArray = [[NSMutableArray alloc]init];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableView Delegate Methods

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (_resultArray != nil) {
        return _resultArray.count;
    } else {
        return 0;
    }
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIdentifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
        [cell setBackgroundColor:[UIColor clearColor]];
    }
    
    MKMapItem *mapItem = [_resultArray objectAtIndex:indexPath.row];
    [cell.textLabel setText:mapItem.placemark.name];
    
    return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
