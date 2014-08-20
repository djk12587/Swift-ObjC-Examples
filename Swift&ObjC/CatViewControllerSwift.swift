//
//  CatViewControllerSwift.swift
//  Swift&ObjC
//
//  Created by Daniel Koza on 8/7/14.
//  Copyright (c) 2014 Allstate R&D. All rights reserved.
//

import UIKit

extension UIImage {
    class func loadFromURL(url:NSURL, callBack:(image:UIImage) -> ()) {
        
        var callerQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0)
        
        dispatch_async(callerQueue, {
            var imageData = NSData.dataWithContentsOfURL(url, options: NSDataReadingOptions.DataReadingMappedAlways, error: nil)
            dispatch_async(dispatch_get_main_queue(), {
                var image = UIImage(data: imageData)
                callBack(image: image)
            })
        })
    }
}

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
            
            if connectionError == nil && data.length > 0 {

                var jsonErrorOptional: NSError?
                let jsonOptional: AnyObject! = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions(0), error: &jsonErrorOptional)

                let success:String = jsonOptional["success"] as String

                if success == "true" {
                    let catFactArray:Array<String> = jsonOptional["facts"] as Array<String>
                    let fact:String = catFactArray[0]
                    weakSelf!.myLabel.text = fact
                } else {
                    weakSelf!.myLabel.text = "There was an error getting your cat fact :("
                }
                
            } else {
                weakSelf!.myLabel.text = "There was an error getting your cat fact :("
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
