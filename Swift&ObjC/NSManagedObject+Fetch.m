//
//  NSManagedObject+Fetch.m
//  MotionData
//
//  Created by Daniel Koza on 8/11/14.
//  Copyright (c) 2014 Allstate. All rights reserved.
//

#import "NSManagedObject+Fetch.h"

@implementation NSManagedObject (Fetch)

+ (NSArray *)core_findAllWithPredicate:(NSPredicate *)predicate inContext:(NSManagedObjectContext *)context {
    return [self find:nil ascending:true predicate:predicate context:context fetchLimit:0];
}

+ (NSArray *)core_findAllSortedBy:(NSString *)sortTerm ascending:(BOOL)ascending withPredicate:(NSPredicate *)predicate inContext:(NSManagedObjectContext *)context {
    return [self find:sortTerm ascending:ascending predicate:predicate context:context fetchLimit:0];
}

+ (NSArray *)find:(NSString *)sortTerm ascending:(BOOL)ascending predicate:(NSPredicate *)predicate context:(NSManagedObjectContext *)context fetchLimit:(NSUInteger)fetchLimit
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:NSStringFromClass(self)];
    fetchRequest.predicate = predicate;
    fetchRequest.sortDescriptors = (sortTerm) ? @[[NSSortDescriptor sortDescriptorWithKey:sortTerm ascending:ascending]] : nil;
    if (fetchLimit > 0) {fetchRequest.fetchLimit = fetchLimit;}
    NSArray *results = [CoreDataHelper core_executeFetchRequest:fetchRequest inContext:context error:nil];
    return results;
}

@end
