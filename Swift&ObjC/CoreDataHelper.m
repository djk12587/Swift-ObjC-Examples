//
//  CoreDataHelper.m
//  GeoAlarm
//
//  Created by Daniel Koza on 7/31/14.
//  With some help from the following Repo "https://github.com/theocalmes/TBCoreDataStack"
//  Copyright (c) 2014 Allstate R&D. All rights reserved.
//


#import "CoreDataHelper.h"

static NSString *const CoreDataModelFileName = @"ObjcModel";

@interface CoreDataHelper ()

@property(strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property(strong, nonatomic) NSManagedObjectModel *managedObjectModel;

@property (strong, nonatomic) NSManagedObjectContext *mainQueueContext;
@property (strong, nonatomic) NSManagedObjectContext *privateQueueContext;

@end

@implementation CoreDataHelper

+ (instancetype)defaultStore
{
    static CoreDataHelper *_defaultStore = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _defaultStore = [self new];
    });
    
    return _defaultStore;
}

#pragma mark - Singleton Access

+ (NSManagedObjectContext *)mainQueueContext
{
    return [[self defaultStore] mainQueueContext];
}

+ (NSManagedObjectContext *)privateQueueContext
{
    return [[self defaultStore] privateQueueContext];
}

+ (NSManagedObjectID *)managedObjectIDFromString:(NSString *)managedObjectIDString
{
    return [[[self defaultStore] persistentStoreCoordinator] managedObjectIDForURIRepresentation:[NSURL URLWithString:managedObjectIDString]];
}


#pragma mark - Getters

- (NSManagedObjectContext *)mainQueueContext
{
    if (!_mainQueueContext) {
        _mainQueueContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
        _mainQueueContext.persistentStoreCoordinator = self.persistentStoreCoordinator;
    }
    
    return _mainQueueContext;
}

- (NSManagedObjectContext *)privateQueueContext
{
    if (!_privateQueueContext) {
        _privateQueueContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType];
        _privateQueueContext.persistentStoreCoordinator = self.persistentStoreCoordinator;
    }
    
    return _privateQueueContext;
}

#pragma mark - Lifecycle

- (id)init
{
    self = [super init];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(contextDidSavePrivateQueueContext:)name:NSManagedObjectContextDidSaveNotification object:[self privateQueueContext]];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(contextDidSaveMainQueueContext:) name:NSManagedObjectContextDidSaveNotification object:[self mainQueueContext]];
    }
    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - Notifications

- (void)contextDidSavePrivateQueueContext:(NSNotification *)notification
{
    @synchronized(self) {
        [self.mainQueueContext performBlock:^{
            [self.mainQueueContext mergeChangesFromContextDidSaveNotification:notification];
        }];
    }
}

- (void)contextDidSaveMainQueueContext:(NSNotification *)notification
{
    @synchronized(self) {
        [self.privateQueueContext performBlock:^{
            [self.privateQueueContext mergeChangesFromContextDidSaveNotification:notification];
        }];
    }
}

#pragma mark - Stack Setup

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (!_persistentStoreCoordinator) {
        _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:self.managedObjectModel];
        NSError *error = nil;
        
        if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:[self persistentStoreURL] options:[self persistentStoreOptions] error:&error]) {
            NSLog(@"Error adding persistent store. %@, %@", error, error.userInfo);
        }
    }
    
    return _persistentStoreCoordinator;
}

- (NSManagedObjectModel *)managedObjectModel
{
    if (!_managedObjectModel) {
        NSURL *modelURL = [[NSBundle mainBundle] URLForResource:CoreDataModelFileName withExtension:@"momd"];
        _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    }
    
    return _managedObjectModel;
}

- (NSURL *)persistentStoreURL
{
    NSString *appName = [[NSBundle mainBundle] infoDictionary][@"CFBundleName"];
    appName = [appName stringByAppendingString:@"ObjC.sqlite"];
    
    return [[CoreDataHelper applicationDocumentsDirectory] URLByAppendingPathComponent:appName];
}

- (NSDictionary *)persistentStoreOptions
{
    return @{NSInferMappingModelAutomaticallyOption: @YES, NSMigratePersistentStoresAutomaticallyOption: @YES, NSSQLitePragmasOption: @{@"synchronous": @"OFF"}};
}

+ (NSURL *)applicationDocumentsDirectory {
    // The directory the application uses to store the Core Data store file. This code uses a directory named "com.allstate.rd.objCCoreData" in the application's documents directory.
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

#pragma mark - Fetch Helper

+ (NSArray *)core_executeFetchRequest:(NSFetchRequest *)request inContext:(NSManagedObjectContext *)context error:(NSError **)error
{
    
    __block NSArray *results = nil;
    [context performBlockAndWait:^{
        results = [context executeFetchRequest:request error:error];
    }];
    
    if (error) {
        NSString *errorMessage = [NSString stringWithFormat:@"Error in fetch request: %@\nError: %@", request, *error];
        NSLog(@"%@",errorMessage);
        *error = [NSError errorWithDomain:NSSQLiteErrorDomain code:1 userInfo:@{@"error" : errorMessage}];
    }
    
    return results;
}

@end
