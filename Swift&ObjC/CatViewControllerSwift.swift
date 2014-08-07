//
//  CatViewControllerSwift.swift
//  Swift&ObjC
//
//  Created by Daniel Koza on 8/7/14.
//  Copyright (c) 2014 Allstate R&D. All rights reserved.
//

import UIKit

class CatViewControllerSwift: CatViewControllerParent {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.myRefreshButton.addTarget(self, action: "getNewCatFact", forControlEvents: UIControlEvents.TouchUpInside)
        getNewCatFact()
    }
    
    func getNewCatFact() {
        
        weak var weakSelf = self
        
        let url = NSURL(string: "http://catfacts-api.appspot.com/api/facts?number=1")
        let request = NSURLRequest(URL: url)
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) {
            (response:NSURLResponse!, data:NSData!, connectionError:NSError!) -> Void in
            
            if data.length > 0 && connectionError == nil {
                
                let catFacts:NSDictionary = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments, error: nil) as NSDictionary
                
                if catFacts["success"].boolValue {
                    weakSelf!.myLabel.text = catFacts["facts"].firstObject as NSString
                } else {
                    weakSelf!.myLabel.text = "There was an error getting your cat fact :("
                }
            }
        }
        
        myActivityIndicator.startAnimating()
        
        UIImage.loadFromURL(NSURL(string: "http://thecatapi.com/api/images/get?format=src&size=small"),
            callBack: { (image) -> () in
                weakSelf!.myImageView.image = image
                weakSelf!.myActivityIndicator.stopAnimating()
        })
    }
}
