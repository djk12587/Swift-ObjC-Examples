//
//  CollectionViewSwift.swift
//  Swift&ObjC
//
//  Created by Daniel Koza on 8/4/14.
//  Copyright (c) 2014 Allstate R&D. All rights reserved.
//

import UIKit

class CollectionViewSwift: CCDetailCollectionViewController {
    
    override func viewDidLoad()  {
        super.viewDidLoad()
        
        self.collectionView.registerNib(UINib(nibName: "MainCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "MainCollectionViewCell")
    }

    override func numberOfSectionsInCollectionView(collectionView: UICollectionView!) -> Int  {
        return 1
    }
    
    override func collectionView(collectionView: UICollectionView!, numberOfItemsInSection section: Int) -> Int  {
        return 6
    }
    
    override func collectionView(collectionView: UICollectionView!, cellForItemAtIndexPath indexPath: NSIndexPath!) -> UICollectionViewCell! {
        var cell:MainCollectionViewCell! = collectionView.dequeueReusableCellWithReuseIdentifier("MainCollectionViewCell", forIndexPath: indexPath) as MainCollectionViewCell
        
        switch indexPath.row {
        case 0:
            cell!.imageView.image = UIImage(named:"mayhem1.png")
            cell.textLabel.text = "mayhem maid"
        case 1:
            cell!.imageView.image = UIImage(named:"mayhem2.png")
            cell.textLabel.text = "mayhem branch"
        case 2:
            cell!.imageView.image = UIImage(named:"mayhem3.png")
            cell.textLabel.text = "mayhem becky"
        case 3:
            cell!.imageView.image = UIImage(named:"mayhem4.png")
            cell.textLabel.text = "mayhem blind spot"
        case 4:
            cell!.imageView.image = UIImage(named:"mayhem5.png")
            cell.textLabel.text = "mayhem jogger"
        default:
            cell!.imageView.image = UIImage(named:"mayhem6.png")
            cell.textLabel.text = "mayhem"
        }
        
        
        
        return cell;
        
    }
}
