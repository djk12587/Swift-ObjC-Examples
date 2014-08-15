//
//  CoreDataHelper.h
//  GeoAlarm
//
//  Created by Daniel Koza on 7/31/14.
//  Copyright (c) 2014 Allstate R&D. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface CoreDataHelper : NSObject

//initialize the core data stack, this should be called in the app delegate application did finish launching
//+ (BOOL)setUpCoreDataStack:(NSError **)error;

+ (instancetype)defaultStore;

+ (NSManagedObjectContext *)mainQueueContext;
+ (NSManagedObjectContext *)privateQueueContext;
+ (NSManagedObjectID *)managedObjectIDFromString:(NSString *)managedObjectIDString;
+ (NSArray *)core_executeFetchRequest:(NSFetchRequest *)request inContext:(NSManagedObjectContext *)context error:(NSError **)error;

@end
