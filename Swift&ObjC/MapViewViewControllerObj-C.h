//
//  MapViewViewControllerObj-C.h
//  Swift&ObjC
//
//  Created by Daniel Koza on 8/6/14.
//  Copyright (c) 2014 Allstate R&D. All rights reserved.
//

#import "MapViewControllerParent.h"

@interface MapViewViewControllerObj_C : MapViewControllerParent <UISearchBarDelegate, UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UISearchBar *mySearchBar;
@property (nonatomic, strong) NSMutableArray *resultArray;
@property (nonatomic, strong) MKLocalSearch *localSearch;

@end
