//
//  MainCollectionViewCell.m
//  CCIntegrator
//
//  Created by Daniel Koza on 7/16/14.
//  Copyright (c) 2014 Allstate R&D. All rights reserved.
//

#import "MainCollectionViewCell.h"

@implementation MainCollectionViewCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void) awakeFromNib {
    [super awakeFromNib];
    
    self.opaque = NO;
    self.backgroundColor = [UIColor clearColor];
    
    self.cellContentView.layer.cornerRadius = 10.0;
    self.cellContentView.layer.borderWidth = 1.0;
    self.cellContentView.layer.borderColor = [UIColor blackColor].CGColor;
    [self.contentView setBackgroundColor:[UIColor colorWithRed:24.0f/255.0f green:72.0f/255.0f blue:124.0f/255.0f alpha:1.0]];

}

-(void) setHighlighted:(BOOL)highlighted {
    [super setHighlighted:highlighted];
    
    if (highlighted) {
        [self setAlpha:0.75f];
    } else {
        [self setAlpha:1.0f];
    }
}


@end
