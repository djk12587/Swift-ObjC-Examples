//
//  MainTableViewControllerObj-C.m
//  Swift&ObjC
//
//  Created by Daniel Koza on 8/4/14.
//  Copyright (c) 2014 Allstate R&D. All rights reserved.
//

#import "MainTableViewControllerObj-C.h"
#import "UIKitExamplesObj-C.h"
#import "CollectionViewObj-C.h"
#import "PageViewControllerObj-C.h"
#import "MapViewViewControllerObj-C.h"
#import "CatViewControllerObj-C.h"
#import "CoreDataUsageViewControllerObj-C.h"

@implementation MainTableViewControllerObj_C

- (void) viewDidLoad {
    [super viewDidLoad];
    
    [self setTitle:@"Objective-C"];
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 6;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIdentifier = @"objcCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
    
    switch (indexPath.row) {
        case 0:
            [cell.textLabel setText:@"Buttons, Switches, Sliders etc..."];
            break;
        case 1:
            [cell.textLabel setText:@"UICollectionView"];
            break;
        case 2:
            [cell.textLabel setText:@"UIPageViewController"];
            break;
        case 3:
            [cell.textLabel setText:@"MapView"];
            break;
        case 4:
            [cell.textLabel setText:@"Consume Webservice"];
            break;
        case 5:
            [cell.textLabel setText:@"Core Data"];
            break;
        default:
            [cell.textLabel setText:@"etc.."];
            break;
    }
    return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch (indexPath.row) {
        case 0: {
            UIKitExamplesObj_C *viewController = [[UIKitExamplesObj_C alloc]initWithNibName:@"UIKitTableViewControllerParent" bundle:nil];
            [self.navigationController pushViewController:viewController animated:YES];
        }
            break;
        case 1: {
            CollectionViewObj_C *viewController = [[CollectionViewObj_C alloc]initWithNibName:@"CCDetailCollectionViewController" bundle:nil];
            [self.navigationController pushViewController:viewController animated:YES];
        }
            break;
        case 2: {
            PageViewControllerObj_C *viewController = [[PageViewControllerObj_C alloc]initWithNibName:@"PageViewControllerParent" bundle:nil];
            [self.navigationController pushViewController:viewController animated:YES];
        }
            break;
        case 3: {
            MapViewViewControllerObj_C *viewController = [[MapViewViewControllerObj_C alloc]initWithNibName:@"MapViewControllerParent" bundle:nil];
            [self.navigationController pushViewController:viewController animated:YES];
        }
            break;
        case 4: {
            CatViewControllerObj_C *viewController = [[CatViewControllerObj_C alloc]initWithNibName:@"CatViewControllerParent" bundle:nil];
            [self.navigationController pushViewController:viewController animated:YES];
        }
            break;
        default: {
            CoreDataUsageViewControllerObj_C *viewController = [[CoreDataUsageViewControllerObj_C alloc]initWithNibName:@"CoreDataUsageViewController" bundle:nil];
            [self.navigationController pushViewController:viewController animated:YES];
        }
            break;
    }
    
    
    
}

@end
