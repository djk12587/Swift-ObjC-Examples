//
//  CollectionViewObj-C.m
//  Swift&ObjC
//
//  Created by Daniel Koza on 8/4/14.
//  Copyright (c) 2014 Allstate R&D. All rights reserved.
//

#import "CollectionViewObj-C.h"

@implementation CollectionViewObj_C

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.collectionView registerNib:[UINib nibWithNibName:@"MainCollectionViewCell" bundle: nil] forCellWithReuseIdentifier:@"MainCollectionViewCell"];
}

#pragma mark - UICollectionView Delegate methods

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 6;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    MainCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MainCollectionViewCell" forIndexPath:indexPath];
    
    switch (indexPath.row) {
        case 0: {
            [cell.imageView setImage:[UIImage imageNamed:@"mayhem1.png"]];
        }
            break;
        case 1: {
            [cell.imageView setImage:[UIImage imageNamed:@"mayhem2.png"]];
        }
            break;
        case 2: {
            [cell.imageView setImage:[UIImage imageNamed:@"mayhem3.png"]];
        }
            break;
        case 3: {
            [cell.imageView setImage:[UIImage imageNamed:@"mayhem4.png"]];
        }
            break;
        case 4: {
            [cell.imageView setImage:[UIImage imageNamed:@"mayhem5.png"]];
        }
            break;
            
        default: {
            [cell.imageView setImage:[UIImage imageNamed:@"mayhem6.png"]];
        }
            break;
    }
    
    [cell.textLabel setText:@"cell text label"];
    
    return cell;
}

@end
