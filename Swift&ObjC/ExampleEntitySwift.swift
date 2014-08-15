//
//  ExampleEntitySwift.swift
//  Swift&ObjC
//
//  Created by Daniel Koza on 8/15/14.
//  Copyright (c) 2014 Allstate R&D. All rights reserved.
//

import Foundation
import CoreData

@objc (ExampleEntitySwift)
class ExampleEntitySwift: NSManagedObject {

    @NSManaged var date: NSDate

}
