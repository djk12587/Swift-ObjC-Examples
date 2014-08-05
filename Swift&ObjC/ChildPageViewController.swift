//
//  ChildPageViewController.swift
//  Swift&ObjC
//
//  Created by Daniel Koza on 8/5/14.
//  Copyright (c) 2014 Allstate R&D. All rights reserved.
//

import UIKit

class ChildPageViewController: UIViewController {
    
    var index:NSNumber!
    @IBOutlet weak var screenNumber: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.screenNumber.text = "Screen #\(index!)"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
