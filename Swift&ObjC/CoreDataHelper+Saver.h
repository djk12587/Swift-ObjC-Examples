//
//  CoreDataHelper+Saver.h
//  MotionData
//
//  Created by Daniel Koza on 8/12/14.
//  Copyright (c) 2014 Allstate. All rights reserved.
//

#import "CoreDataHelper.h"

@interface CoreDataHelper (Saver)

//Perform saves in the main context on the main UI thread
+ (void)core_saveInMainContext:(CoreSimpleBlock)changes;

//Perform all the changes in a background queue and then merge everything into the main context
+ (void)core_saveInBackground:(CoreSimpleBlock)changes;

//Perform all the changes in a background queue and then merge everything into the main context.
//The completion block is called straight after the background context has been saved and
//all the changes might not be merged into the main context yet.
+ (void)core_saveInBackground:(CoreSimpleBlock)changes completion:(CoreErrorBlock)completion;
@end
