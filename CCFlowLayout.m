//
//  CCFlowLayout.m
//  CCIntegrator
//
//  Created by Daniel Koza on 7/16/14.
//  Copyright (c) 2014 Allstate R&D. All rights reserved.
//

#import "CCFlowLayout.h"

@implementation CCFlowLayout

- (instancetype)init {
    
    self = [super init];
    
    if (self) [self initLayout];
    
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    
    self = [super initWithCoder:aDecoder];
    
    if (self) [self initLayout];
    
    return self;
}

- (void)initLayout {
    [self setMinimumInteritemSpacing:10.0f];
    [self setMinimumLineSpacing:10.0f];
    
    [self setSectionInset:UIEdgeInsetsMake(15, 15, 0, 15)];
    [self setScrollDirection:UICollectionViewScrollDirectionVertical];

    [self setItemSize:CGSizeMake(140, 140)];
    
}

@end
