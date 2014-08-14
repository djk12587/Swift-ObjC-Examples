//
//  NSManagedObject+Fetch.h
//  MotionData
//
//  Created by Daniel Koza on 8/11/14.
//  Copyright (c) 2014 Allstate. All rights reserved.
//

#import <CoreData/CoreData.h>
#import "CoreDataHelper.h"

@interface NSManagedObject (Fetch)
+ (NSArray *)core_findAllWithPredicate:(NSPredicate *)predicate inContext:(NSManagedObjectContext *)context;
+ (NSArray *)core_findAllSortedBy:(NSString *)sortTerm ascending:(BOOL)ascending withPredicate:(NSPredicate *)predicate inContext:(NSManagedObjectContext *)context;
@end
