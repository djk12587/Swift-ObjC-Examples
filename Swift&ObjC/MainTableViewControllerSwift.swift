//
//  MainTableViewControllerSwift.swift
//  Swift&ObjC
//
//  Created by Daniel Koza on 8/4/14.
//  Copyright (c) 2014 Allstate R&D. All rights reserved.
//

import UIKit

class MainTableViewControllerSwift: MainTableViewControllerParent {
    
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
        
        let identifier = "swiftCell"
        
        var cell:UITableViewCell! = tableView.dequeueReusableCellWithIdentifier(identifier) as? UITableViewCell
        
        if cell == nil {
            cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: identifier)
        }
        
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
            let viewController = UIKitExamplesSwift(nibName: "UIKitTableViewControllerParent", bundle: nil)
            self.navigationController.pushViewController(viewController, animated: true)
        case 1:
            let viewController = CollectionViewSwift(nibName: "CCDetailCollectionViewController", bundle: nil)
            self.navigationController.pushViewController(viewController, animated: true)
        case 2:
            let viewController = PageViewControllerSwift(nibName: "PageViewControllerParent", bundle: nil)
            self.navigationController.pushViewController(viewController, animated: true)
        case 3:
            let viewController = MapViewControllerSwift(nibName: "MapViewControllerParent", bundle: nil)
            self.navigationController.pushViewController(viewController, animated: true)
        default:
            let viewController = CatViewControllerSwift(nibName: "CatViewControllerParent", bundle: nil)
            self.navigationController.pushViewController(viewController, animated: true)
        }
    }

}
