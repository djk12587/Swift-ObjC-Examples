//
//  CoreDataHelperSwift.swift
//  Swift&ObjC
//
//  Created by Daniel Koza on 8/14/14.
//  Copyright (c) 2014 Allstate R&D. All rights reserved.
//

import UIKit
import CoreData

private let _defaultStore = CoreDataHelperSwift()

class CoreDataHelperSwift: NSObject {
    
    lazy var managedObjectModel:NSManagedObjectModel = {
        var modelURL = NSBundle.mainBundle().URLForResource("SwiftModel", withExtension: "momd")
        var objectModel = NSManagedObjectModel(contentsOfURL: modelURL)
        
        return objectModel
    }()

    
    lazy var mainQueueContext:NSManagedObjectContext = {

        var mainContext : NSManagedObjectContext = NSManagedObjectContext(concurrencyType: NSManagedObjectContextConcurrencyType.MainQueueConcurrencyType)
        mainContext.persistentStoreCoordinator = self.persistentStoreCoordinator
        return mainContext

    }()
    
    lazy var privateQueueContext:NSManagedObjectContext = {

        var privateContext : NSManagedObjectContext = NSManagedObjectContext(concurrencyType: NSManagedObjectContextConcurrencyType.PrivateQueueConcurrencyType)
        privateContext.persistentStoreCoordinator = self.persistentStoreCoordinator
        return privateContext

    }()
    
    lazy var persistentStoreCoordinator:NSPersistentStoreCoordinator = {
        var error:NSError?
        
        var persistentCoordinator = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
        
        if !persistentCoordinator.addPersistentStoreWithType(NSSQLiteStoreType, configuration: nil, URL: self.persistentStoreURL(), options: self.persistentStoreOptions(), error: &error) {
            println("Error adding persistent Store \(error)")
        }
        return persistentCoordinator
    }()
    
    override init() {
        super.init()
        
        println("init Method Called");
    }
    
    class var defaultStore: CoreDataHelperSwift {
        return _defaultStore
    }

    func persistentStoreURL() -> NSURL
    {
        println(NSBundle.mainBundle().infoDictionary)
        var appName:NSString? = NSBundle.mainBundle().infoDictionary["CFBundleName"] as? NSString
        println(appName)
        appName = appName?.stringByAppendingString(".sqlite")
        return CoreDataHelperSwift.applicationDocumentsDirectory().URLByAppendingPathComponent(appName)
    }

    class func applicationDocumentsDirectory() -> NSURL {
        
        return NSFileManager.defaultManager().URLsForDirectory(NSSearchPathDirectory.DocumentDirectory, inDomains: NSSearchPathDomainMask.UserDomainMask)[0] as NSURL
    }
    
    func persistentStoreOptions() -> NSDictionary {
        return NSDictionary(objectsAndKeys: NSInferMappingModelAutomaticallyOption,"YES", NSMigratePersistentStoresAutomaticallyOption, "YES", NSSQLitePragmasOption, ["synchronous":"OFF"])
    }
    
    //MARK: - Singleton Access
    
    class func getPrivateQueueContext() -> NSManagedObjectContext {
        return _defaultStore.privateQueueContext
    }

    class func getMainQueueContext() -> NSManagedObjectContext {
        return _defaultStore.mainQueueContext
    }
    
}
