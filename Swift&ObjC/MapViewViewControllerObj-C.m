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
    
    [self.myMapView setDelegate:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) tableViewShouldBeVisible:(BOOL)isVisible withCompletion:(void (^) (void))completed {
    CGFloat alplha = 0.0;
    
    if (isVisible) {
        alplha = 1.0;
    }
    
    __weak __block MapViewViewControllerObj_C *weakSelf = self;
    
    [UIView animateWithDuration:0.3 animations:^{
        [weakSelf.myResultsTableView setAlpha:alplha];
    } completion:^(BOOL finished) {
        completed();
    }];
    
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

    [_mySearchBar resignFirstResponder];
    
    __weak __block MapViewViewControllerObj_C *weakSelf = self;
    [self tableViewShouldBeVisible:false withCompletion:^{
        MKMapItem *mapItem = [weakSelf.resultArray objectAtIndex:indexPath.row];
        
        MKPointAnnotation *annotationPin = [[MKPointAnnotation alloc]init];
        [annotationPin setCoordinate:mapItem.placemark.coordinate];
        [annotationPin setTitle:mapItem.placemark.name];
        
        [weakSelf.myMapView addAnnotation:annotationPin];
        [weakSelf.myMapView selectAnnotation:annotationPin animated:YES];
        
    }];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void) scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [_mySearchBar resignFirstResponder];
}

#pragma mark - UISearchBar Delegate Methods

- (void) searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    [searchBar setShowsCancelButton:YES animated:YES];
    [self tableViewShouldBeVisible:YES withCompletion:^{}];
}

- (void) searchBarTextDidEndEditing:(UISearchBar *)searchBar {
    [searchBar setShowsCancelButton:NO animated:YES];
    if (_resultArray.count == 0) {
        [self tableViewShouldBeVisible:false withCompletion:^{}];
    }
}

- (void) searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    [searchBar resignFirstResponder];
    [self tableViewShouldBeVisible:false withCompletion:^{}];
}

- (void) searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    MKLocalSearchRequest *searchRequest = [[MKLocalSearchRequest alloc]init];
    [searchRequest setNaturalLanguageQuery:searchText];
    
    __weak __block MapViewViewControllerObj_C *weakSelf = self;
    
    MKLocalSearchCompletionHandler completionHandler = ^void(MKLocalSearchResponse *response, NSError *error) {
        if (error == nil) {
            if (weakSelf.resultArray) {
                [weakSelf.resultArray removeAllObjects];
            } else {
                weakSelf.resultArray = [[NSMutableArray alloc]init];
            }
            
            for (MKMapItem *item in response.mapItems) {
                [weakSelf.resultArray addObject:item];
            }
            
            [weakSelf.myResultsTableView reloadData];
        } else {
            //there was an error with the response
        }
    };
    
    if (_localSearch && _localSearch.searching) {
        [_localSearch cancel];
    }
    
    _localSearch = [[MKLocalSearch alloc]initWithRequest:searchRequest];
    [_localSearch startWithCompletionHandler:completionHandler];

}

#pragma mark - UIMapView Delegate Methods

- (MKAnnotationView *) mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
    MKPinAnnotationView *pinView = nil;
    
    static NSString *pinIdentifier = @"pinID";
    
    pinView = (MKPinAnnotationView *)[self.myMapView dequeueReusableAnnotationViewWithIdentifier:pinIdentifier];
    
    if (pinView == nil) {
        pinView = [[MKPinAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:pinIdentifier];
    }
    
    [pinView setAnimatesDrop:YES];
    [pinView setCanShowCallout:YES];
    
    return pinView;
}

@end
