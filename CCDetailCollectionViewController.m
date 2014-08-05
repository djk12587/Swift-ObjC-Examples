//
//  CCDetailCollectionViewController.m
//  CCIntegrator
//
//  Created by Daniel Koza on 7/16/14.
//  Copyright (c) 2014 Allstate R&D. All rights reserved.
//

#import "CCDetailCollectionViewController.h"
#import "CCFlowLayout.h"

@interface CCDetailCollectionViewController ()

@end

@implementation CCDetailCollectionViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [self initialize];
    }
    return self;
}

- (void) awakeFromNib {
    [super awakeFromNib];
    [self initialize];
}

- (void) initialize {
    CCFlowLayout *layout = [[CCFlowLayout alloc]init];
    [self.collectionView setCollectionViewLayout:layout];
    [self.collectionView setBounces:YES];
    [self.collectionView setAlwaysBounceVertical:YES];
    [self.collectionView setDelaysContentTouches:NO];
    [self.collectionView setBackgroundColor:[UIColor colorWithRed:0.0f/255.0f green:140.0f/255.0f blue:201.0f/255.0f alpha:1.0]];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
