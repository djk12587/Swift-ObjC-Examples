//
//  MainTableViewControllerObj-C.m
//  Swift&ObjC
//
//  Created by Daniel Koza on 8/4/14.
//  Copyright (c) 2014 Allstate R&D. All rights reserved.
//

#import "MainTableViewControllerObj-C.h"

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
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"objcCell"];
    
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
    
    [self performSegueWithIdentifier:@"UIKitExamplesObjc" sender:nil];
}

@end
