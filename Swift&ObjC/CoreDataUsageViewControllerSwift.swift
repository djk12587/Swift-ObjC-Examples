//
//  CoreDataUsageViewControllerSwift.swift
//  Swift&ObjC
//
//  Created by Daniel Koza on 8/18/14.
//  Copyright (c) 2014 Allstate R&D. All rights reserved.
//

import UIKit

class CoreDataUsageViewControllerSwift: CoreDataUsageViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.addARecordButton.addTarget(self, action: "addARecord", forControlEvents: UIControlEvents.TouchUpInside)
        self.deleteAllButton.addTarget(self, action: "deleteAll", forControlEvents: UIControlEvents.TouchUpInside)
        
        var fetchResult = ExampleEntitySwift.core_findAllSortedBy("date", ascending: false, predicate: nil, context: CoreDataHelperSwift.getPrivateQueueContext())

        self.resultsArray = NSMutableArray(array: fetchResult!)
        
    }
    
    func addARecord(){
        
        weak var weakSelf = self
        
        CoreDataHelperSwift.core_saveInPrivateQueue({ () -> () in
            
            var entity:ExampleEntitySwift = ExampleEntitySwift.core_createInContext(CoreDataHelperSwift.getPrivateQueueContext()) as ExampleEntitySwift
            entity.date = NSDate()
            
            weakSelf?.resultsArray.insertObject(entity, atIndex: 0)
            
        }, completion: { (error) -> () in
            if weakSelf != nil && error == nil {
                weakSelf!.coreDataTableView.reloadData()
            }
        })
    }
    
    func deleteAll() {
        weak var weakSelf = self
        CoreDataHelperSwift.core_saveInPrivateQueue({ () -> () in
            
            if weakSelf != nil {
                for entity in weakSelf!.resultsArray {
                    CoreDataHelperSwift.getPrivateQueueContext().deleteObject(entity as ExampleEntitySwift)
                }
                weakSelf?.resultsArray.removeAllObjects()
            }

        }, completion: { (error) -> () in
            if weakSelf != nil && error == nil {
                weakSelf!.coreDataTableView.reloadData()
            }
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
