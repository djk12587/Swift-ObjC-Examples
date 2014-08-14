//
//  NSManagedObject+Creation.h
//  MotionData
//
//  Created by Daniel Koza on 8/11/14.
//  Copyright (c) 2014 Allstate. All rights reserved.
//

#import <CoreData/CoreData.h>

@interface NSManagedObject (Creation)

+ (instancetype) core_createInContext:(NSManagedObjectContext *)context;

@end
