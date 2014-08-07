//
//  CatViewControllerObj-C.m
//  Swift&ObjC
//
//  Created by Daniel Koza on 8/7/14.
//  Copyright (c) 2014 Allstate R&D. All rights reserved.
//

#import "CatViewControllerObj-C.h"
#import "Swift_ObjC-Swift.h"
#import "UIImage+Helper.h"

@interface CatViewControllerObj_C ()

@end

@implementation CatViewControllerObj_C

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.myRefreshButton addTarget:self action:@selector(getNewCatFact) forControlEvents:UIControlEventTouchUpInside];
    [self getNewCatFact];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) getNewCatFact {
    
    __weak __block CatViewControllerObj_C *weakSelf = self;
    
    NSURL *url = [NSURL URLWithString:@"http://catfacts-api.appspot.com/api/facts?number=1"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        if (data.length > 0 && connectionError == nil)
        {
            NSDictionary *catFacts = [NSJSONSerialization JSONObjectWithData:data
                                                                     options:0
                                                                       error:NULL];
            
            if ([catFacts[@"success"] boolValue]) {
                [weakSelf.myLabel setText:[catFacts[@"facts"]firstObject]];
            } else {
                [weakSelf.myLabel setText:@"There was an error getting your cat fact :("];
            }
        }
    }];
    
    [self.myActivityIndicator startAnimating];
    
    [UIImage loadFromURL:[NSURL URLWithString:@"http://thecatapi.com/api/images/get?format=src&size=small"] callBack:^(UIImage *image) {
        [weakSelf.myImageView setImage:image];
        [weakSelf.myActivityIndicator stopAnimating];
    }];
}

@end
