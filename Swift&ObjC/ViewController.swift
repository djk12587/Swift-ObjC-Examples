//
//  ViewController.swift
//  Swift&ObjC
//
//  Created by Daniel Koza on 8/4/14.
//  Copyright (c) 2014 Allstate R&D. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
                            
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func swiftAction(sender: AnyObject) {
        let viewController = MainTableViewControllerSwift(nibName: "MainTableViewControllerParent", bundle: nil)
        self.navigationController?.pushViewController(viewController, animated: true)
    }

    @IBAction func objCAction(sender: AnyObject) {
        let viewController = MainTableViewControllerObj_C(nibName: "MainTableViewControllerParent", bundle: nil)
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}

