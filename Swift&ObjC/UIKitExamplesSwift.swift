//
//  UIKitExamplesSwift.swift
//  Swift&ObjC
//
//  Created by Daniel Koza on 8/4/14.
//  Copyright (c) 2014 Allstate R&D. All rights reserved.
//

import UIKit

class UIKitExamplesSwift: UIKitTableViewControllerParent, UITextFieldDelegate {
    
    override func viewDidLoad()  {
        super.viewDidLoad()
        
        self.tableView.keyboardDismissMode = UIScrollViewKeyboardDismissMode.OnDrag;
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int  {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int  {
        return 6
    }
    
    func updateCell(cell:UITableViewCell, indexPath:NSIndexPath) {
        switch indexPath.row {
        case 0:
            
            println(cell.accessoryView)
            
            if (cell.accessoryView == nil || !cell.accessoryView!.isMemberOfClass(UISwitch)) {
                let switchView = UISwitch()
                switchView.addTarget(self, action: "switchToggle:", forControlEvents: UIControlEvents.ValueChanged)
                cell.accessoryView = switchView
            }
            
            let switchViewInCell = cell.accessoryView as UISwitch
            cell.textLabel?.text = "Switch: \(switchViewInCell.on)"
            
        case 1:
            
            if cell.accessoryView == nil || !cell.accessoryView!.isMemberOfClass(UIButton) {
                var button:UIButton = UIButton.buttonWithType(UIButtonType.Custom) as UIButton
                button.frame = CGRectMake(0, 0, 100, 40)
                button.backgroundColor = UIColor.redColor()
                button.setTitle("button", forState: UIControlState.Normal)
                cell.accessoryView = button
            }
            
            cell.textLabel?.text = "Button:"
            
        case 2:
            if cell.accessoryView == nil || !cell.accessoryView!.isMemberOfClass(UISlider) {
                
                let slider = UISlider()
                slider.minimumValue = 0
                slider.maximumValue = 9
                slider.addTarget(self, action: "sliderValueChanged:", forControlEvents: UIControlEvents.ValueChanged)
                cell.accessoryView = slider
            }
            let sliderInView = cell.accessoryView as UISlider
            
            cell.textLabel?.text = "Slider: \(Int(sliderInView.value))"
            
        case 3:
            
            if cell.accessoryView == nil || !cell.accessoryView!.isMemberOfClass(UIProgressView) {
                let progressBar = UIProgressView(progressViewStyle: UIProgressViewStyle.Default)
                cell.accessoryView = progressBar
            }
            
            cell.selectionStyle = UITableViewCellSelectionStyle.Default
            cell.textLabel?.text = "Progress:"
            
        case 4:
            
            if cell.accessoryView == nil || !cell.accessoryView!.isMemberOfClass(UITextField) {
                let textField = UITextField(frame: CGRectMake(0, 0, 180, 33))
                textField.borderStyle = UITextBorderStyle.RoundedRect
                textField.delegate = self
                textField.returnKeyType = UIReturnKeyType.Done
                cell.accessoryView = textField
            }
            cell.textLabel?.text = "Text Field:"
            
        default:
            cell.textLabel?.text = "AlertController:"
            cell.detailTextLabel?.text = "tap to view"
            cell.selectionStyle = UITableViewCellSelectionStyle.Default
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell  {
        
        let cellIdentifier = "cellIdentifier"
        
        if let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier) as? UITableViewCell {
            updateCell(cell, indexPath: indexPath)
            return cell
        } else {
            let cell = UITableViewCell(style: UITableViewCellStyle.Value1, reuseIdentifier: cellIdentifier)
            cell.selectionStyle = UITableViewCellSelectionStyle.None
            updateCell(cell, indexPath: indexPath)
            
            return cell
        }
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)  {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        switch indexPath.row {
        case 5:
            var alert = UIAlertController(title: "Alert", message: "Message", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        case 3:
            let progressView = tableView.cellForRowAtIndexPath(indexPath)?.accessoryView as UIProgressView
            if progressView.progress > 0 {
                progressView.setProgress(0, animated: true)
            } else {
                progressView.setProgress(1, animated: true)
            }
        default:
            println("")
        }
    }
    
    func switchToggle(switchView:UISwitch) {
        let cell = self.tableView.cellForRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 0))
        cell?.textLabel?.text = "Switch: \(switchView.on)"
    }
    
    func sliderValueChanged(slider:UISlider) {
        let cell = self.tableView.cellForRowAtIndexPath(NSIndexPath(forRow: 2, inSection: 0))
        cell?.textLabel?.text = "Slider: \(Int(slider.value))"
    }
    
    func textFieldShouldReturn(textField: UITextField!) -> Bool  {
        textField.resignFirstResponder()
        return true
    }
    
}
