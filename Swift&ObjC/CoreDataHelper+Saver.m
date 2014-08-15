//
//  CoreDataHelper+Saver.m
//  MotionData
//
//  Created by Daniel Koza on 8/12/14.
//  Copyright (c) 2014 Allstate. All rights reserved.
//

#import "CoreDataHelper+Saver.h"

@implementation CoreDataHelper (Saver)

+ (void)core_saveInMainContext:(CoreSimpleBlock)changes
{
    
    NSManagedObjectContext *context = [[self defaultStore] mainQueueContext];
    
    [context performBlock:^{
        
        changes();
        
        NSError *error;
        [context save:&error];
        
        if (error) {
            NSLog(@"Error saving main context: %@", error);
        }
        
    }];
}

+ (void)core_saveInPrivateContext:(CoreSimpleBlock)changes {
    [self core_saveInPrivateContext:changes completion:nil];
}

+ (void)core_saveInPrivateContext:(CoreSimpleBlock)changes completion:(CoreErrorBlock)completion {
    NSManagedObjectContext *privateContext = [[self defaultStore] privateQueueContext];
    
    [privateContext performBlock:^{
        
        changes();
        
        NSError *error;
        [privateContext save:&error];
        
        if (error) {
            NSLog(@"Error saving background context: %@", error);
        }
        
        if (completion) {
            dispatch_async(dispatch_get_main_queue(), ^{
                completion(error);
            });
        }
        
    }];
}
@end
