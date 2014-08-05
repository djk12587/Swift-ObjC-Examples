//
//  MainCollectionViewCell.h
//  CCIntegrator
//
//  Created by Daniel Koza on 7/16/14.
//  Copyright (c) 2014 Allstate R&D. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIView *cellContentView;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *textLabel;

@end
