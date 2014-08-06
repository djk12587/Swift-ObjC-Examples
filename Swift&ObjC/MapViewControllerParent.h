//
//  MapViewControllerParent.h
//  Swift&ObjC
//
//  Created by Daniel Koza on 8/6/14.
//  Copyright (c) 2014 Allstate R&D. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface MapViewControllerParent : UIViewController

@property (weak, nonatomic) IBOutlet MKMapView *myMapView;
@property (weak, nonatomic) IBOutlet UITableView *myResultsTableView;

@end
