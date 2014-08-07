//
//  MapViewControllerSwift.swift
//  Swift&ObjC
//
//  Created by Daniel Koza on 8/6/14.
//  Copyright (c) 2014 Allstate R&D. All rights reserved.
//

import UIKit

class MapViewControllerSwift: MapViewControllerParent, UISearchBarDelegate , UITableViewDelegate, UITableViewDataSource, MKMapViewDelegate {
    
    let mySearchBar = UISearchBar()
    var resultArray = NSMutableArray()
    var localSearch:MKLocalSearch?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        mySearchBar.searchBarStyle = UISearchBarStyle.Minimal
        mySearchBar.placeholder = "Search for a Location"
        mySearchBar.delegate = self
        self.navigationItem.titleView = mySearchBar
        
        myResultsTableView.delegate = self
        myResultsTableView.dataSource = self
        myResultsTableView.keyboardDismissMode = UIScrollViewKeyboardDismissMode.OnDrag
        myResultsTableView.backgroundColor = UIColor(white: 1.0, alpha: 0.0)
        myResultsTableView.alpha = 0.0
        
        var blurEffect = UIBlurEffect(style: .Light)
        var blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = myResultsTableView.bounds
        
        myResultsTableView.backgroundView = blurEffectView
        myResultsTableView.contentInset = UIEdgeInsets(top: 64, left: 0, bottom: 0, right: 0)
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableViewShouldBeVisible(isVisible:Bool, completed:()->()) {
        var alpha:CGFloat = 0.0
        if isVisible {
            alpha = 1.0
        }
        
        weak var weakSelf = self
        UIView.animateWithDuration(0.3, animations: {
            weakSelf!.myResultsTableView!.alpha = alpha
            },
            completion: {
                (value:Bool) in
                completed()
        })
    }
    

    //MARK: UITableview Delegate Methods
    func numberOfSectionsInTableView(tableView: UITableView!) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int {
        if (resultArray != nil) {
            return resultArray.count
        } else {
            return 0
        }
    }
    
    func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell! {
        
        let identifier = "cell"
        
        var cell:UITableViewCell! = tableView.dequeueReusableCellWithIdentifier(identifier) as? UITableViewCell
        
        if cell == nil {
            cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: identifier)
            cell.backgroundColor = UIColor.clearColor()
        }
        
        var mapItem:MKMapItem = self.resultArray.objectAtIndex(indexPath.row) as MKMapItem
        cell.textLabel.text = mapItem.name
        
        return cell
    }
    
    func tableView(tableView: UITableView!, didSelectRowAtIndexPath indexPath: NSIndexPath!) {
        mySearchBar.resignFirstResponder()
        weak var weakSelf = self
        tableViewShouldBeVisible(false,
            completed: {
                let mapItem = weakSelf!.resultArray.objectAtIndex(indexPath.row) as MKMapItem
                
                var annotationPin = MKPointAnnotation()
                annotationPin.coordinate = mapItem.placemark.coordinate
                annotationPin.title = mapItem.placemark.name
                
                weakSelf!.myMapView.addAnnotation(annotationPin)
                weakSelf!.myMapView.selectAnnotation(annotationPin, animated: true)
        })
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    func scrollViewWillBeginDragging(scrollView: UIScrollView!) {
        mySearchBar.resignFirstResponder()
    }
    
    //MARK: UISearchBar Delegate Methods
    
    func searchBarTextDidBeginEditing(searchBar: UISearchBar!)  {
        searchBar.setShowsCancelButton(true, animated: true)
        
        tableViewShouldBeVisible(true, completed: {})
    }
    
    func searchBarTextDidEndEditing(searchBar: UISearchBar!)  {
        searchBar.setShowsCancelButton(false, animated: true)
        
        if resultArray.count == 0 {
            tableViewShouldBeVisible(false, completed: {})
        }
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar!) {
        searchBar.resignFirstResponder()
        tableViewShouldBeVisible(false, completed: {})
    }
    
    func searchBar(searchBar: UISearchBar!, textDidChange searchText: String!) {
        
        var searchRequest = MKLocalSearchRequest()
        searchRequest.naturalLanguageQuery = searchText
        
        weak var weakSelf = self
        
        var completionHander:MKLocalSearchCompletionHandler = {
            (response:MKLocalSearchResponse!, error:NSError!) in
            if error == nil {

                if (weakSelf!.resultArray != nil) {
                    weakSelf!.resultArray.removeAllObjects()
                } else {
                    weakSelf!.resultArray = NSMutableArray()
                }
                
                for item in response.mapItems {
                    weakSelf!.resultArray.addObject(item)
                }
                
                weakSelf!.myResultsTableView.reloadData()
                
            } else {
                
            }
        }
            
        if localSearch != nil && localSearch!.searching {
            localSearch!.cancel()
        }
        
        localSearch = MKLocalSearch(request: searchRequest)
        localSearch?.startWithCompletionHandler(completionHander)
        
    }
    
    //MARK: UIMapView Delegate Methods
    
    func mapView(mapView: MKMapView!, viewForAnnotation annotation: MKAnnotation!) -> MKAnnotationView! {
        
        var pinView:MKPinAnnotationView!
        
        let pinIdentifier = "pinID"
        pinView = myMapView.dequeueReusableAnnotationViewWithIdentifier(pinIdentifier) as? MKPinAnnotationView
        
        if pinView == nil {
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: pinIdentifier)
        }
        
        pinView.animatesDrop = true
        pinView.canShowCallout = true
        
        return pinView
    }

}
