//
//  NSManagedObject+Creation.m
//  MotionData
//
//  Created by Daniel Koza on 8/11/14.
//  Copyright (c) 2014 Allstate. All rights reserved.
//

#import "NSManagedObject+Creation.h"

@implementation NSManagedObject (Creation)

+ (instancetype) core_createInContext:(NSManagedObjectContext *)context {
    return [NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass(self) inManagedObjectContext:context];
}

@end
