//
//  UIImageHelper.swift
//  Swift&ObjC
//
//  Created by Daniel Koza on 8/7/14.
//  Copyright (c) 2014 Allstate R&D. All rights reserved.
//

import Foundation

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