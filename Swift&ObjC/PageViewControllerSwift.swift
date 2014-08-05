//
//  PageViewControllerSwift.swift
//  Swift&ObjC
//
//  Created by Daniel Koza on 8/5/14.
//  Copyright (c) 2014 Allstate R&D. All rights reserved.
//

import UIKit

class PageViewControllerSwift: UIViewController, UIPageViewControllerDataSource {
    
    var pageController:UIPageViewController!

    override func viewDidLoad() {
        super.viewDidLoad()
        pageController = UIPageViewController(transitionStyle: UIPageViewControllerTransitionStyle.Scroll, navigationOrientation: UIPageViewControllerNavigationOrientation.Horizontal, options: nil)
        
        pageController.dataSource = self
        pageController.view.frame = self.view.bounds
        
        var initialChildViewController = viewControllerAtIndex(0)
        var viewControllers:NSArray = NSArray(object: initialChildViewController)
        
        pageController.setViewControllers(viewControllers, direction: UIPageViewControllerNavigationDirection.Forward, animated: false, completion: nil)
        
        self.addChildViewController(pageController)
        self.view.addSubview(pageController.view)
        pageController.didMoveToParentViewController(self)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func viewControllerAtIndex(index:NSInteger) -> ChildPageViewController {
        var childViewController = ChildPageViewController(nibName: "ChildPageViewController", bundle: nil)
        childViewController.index = NSNumber(integer: index)
        return childViewController
    }
    
    //MARK: UIPageControllerDataSource Methods
    func pageViewController(pageViewController: UIPageViewController!, viewControllerBeforeViewController viewController: UIViewController!) -> UIViewController! {
        var childViewController = viewController as ChildPageViewController
        var index:NSInteger! = childViewController.index.integerValue
        
        if index == 0 || index == nil {
            return nil
        }
        
        index!--
        
        return viewControllerAtIndex(index)
    }
    
    func pageViewController(pageViewController: UIPageViewController!, viewControllerAfterViewController viewController: UIViewController!) -> UIViewController! {
        var childViewController = viewController as ChildPageViewController
        var index:NSInteger! = childViewController.index.integerValue
        
        index!++
        
        if index == 5  || index == nil {
            return nil
        }
        
        return viewControllerAtIndex(index)
    }
    
    func presentationCountForPageViewController(pageViewController: UIPageViewController!) -> Int {
        return 5
    }
    
    func presentationIndexForPageViewController(pageViewController: UIPageViewController!) -> Int {
        return 0
    }

}
