//
//  MainTableViewControllerSwift.swift
//  Swift&ObjC
//
//  Created by Daniel Koza on 8/4/14.
//  Copyright (c) 2014 Allstate R&D. All rights reserved.
//

import UIKit

class MainTableViewControllerSwift: UITableViewController {
    
    override func viewDidLoad()  {
        super.viewDidLoad()
        
        self.title = "Swift"
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView!) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    override func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell! {
        var cell:UITableViewCell = tableView.dequeueReusableCellWithIdentifier("swiftCell") as UITableViewCell
        
        switch indexPath.row {
        case 0:
            cell.textLabel.text = "Buttons, switches, sliders etc..."
        case 1:
            cell.textLabel.text = "UICollectionView"
        case 2:
            cell.textLabel.text = "UIPageViewController"
        case 3:
            cell.textLabel.text = "MapView"
        case 4:
            cell.textLabel.text = "Consume Webservice"
        case 5:
            cell.textLabel.text = "Core Data"
        default:
            cell.textLabel.text = "etc.."
        }
        return cell;
    }
    
    override func tableView(tableView: UITableView!, didSelectRowAtIndexPath indexPath: NSIndexPath!)  {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        switch indexPath.row {
        case 0:
            self.performSegueWithIdentifier("UIKitExamplesSwift", sender: nil)
        case 1:
            self.performSegueWithIdentifier("UICollectionViewSwift", sender: nil)
        default:
            self.performSegueWithIdentifier("PageViewControllerSwift", sender: nil)
        }
    }

}
