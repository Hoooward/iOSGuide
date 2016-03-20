//
//  ItemViewController.swift
//  iOSGuide
//
//  Created by Howard on 3/16/16.
//  Copyright © 2016 Howard. All rights reserved.
//

import UIKit

class ItemViewController: UITableViewController, UITextFieldDelegate {
    
    // MARK: Properties
    var itemStore: ItemStore!
    var imageStore: ImageStore = ImageStore()
    var item: Item!
    
    // MARK: UIView lift clyle
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        navigationItem.leftBarButtonItem = editButtonItem()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // custom row height
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 65
        
        
    }
    
    // MARK: Segue
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ShowItem" {
            
            if let row = tableView.indexPathForSelectedRow?.row {
                let item = itemStore.allItems[row]
                let detailViewController = segue.destinationViewController as! DetailViewController
                detailViewController.item = item
                detailViewController.imageStore = imageStore
            }
        }
    }
    
    // IBAction
    @IBAction func dismissMyself(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    @IBAction func addNewItem(sender: AnyObject) {
        
        let newItem = itemStore.creatItems()
        
        if let index = itemStore.allItems.indexOf(newItem) {
            let indexPath = NSIndexPath(forRow: index, inSection: 0)
            tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
        }
    }
    
    // MARK: UITableViewController Delegate
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        if editingStyle == .Delete {
            let item = itemStore.allItems[indexPath.row]
            
            let title = "Delete \(item.name)"
            let message = "Are you sure you want to delete this item?"
            
            let alertController = UIAlertController(title: title, message: message, preferredStyle: .ActionSheet)
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
            let deleteAction = UIAlertAction(title: "Delete", style: .Destructive, handler: { (action) -> Void in
                self.itemStore.removeItem(item)
                self.imageStore.deleteImageForKey(item.itemKey)
                tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
            })
            
            
            alertController.addAction(cancelAction)
            alertController.addAction(deleteAction)
            
            presentViewController(alertController, animated: true, completion: nil)
        }
        
    }
    

    

    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return indexPath.row == itemStore.allItems.count ? false : true
    }
    
    override func tableView(tableView: UITableView, titleForDeleteConfirmationButtonForRowAtIndexPath indexPath: NSIndexPath) -> String? {
        return "Remove"
    }
    
    override func tableView(tableView: UITableView, moveRowAtIndexPath sourceIndexPath: NSIndexPath, toIndexPath destinationIndexPath: NSIndexPath) {
        
//        if destinationIndexPath.row == itemStore.allItems.count {
//            return
//        } else {
            itemStore.moveItemAtIndex(sourceIndexPath.row, toIndex: destinationIndexPath.row)
//        }
    }
    
    
    override func tableView(tableView: UITableView, targetIndexPathForMoveFromRowAtIndexPath sourceIndexPath: NSIndexPath, toProposedIndexPath proposedDestinationIndexPath: NSIndexPath) -> NSIndexPath {
        if proposedDestinationIndexPath.row == itemStore.allItems.count {
            return NSIndexPath(forRow: itemStore.allItems.count - 1, inSection: 0)
        } else {
            return proposedDestinationIndexPath
        }
    }
    
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return indexPath.row == itemStore.allItems.count ? false : true
    }
    
    
    
    // MARK: UITableViewController Datasource
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemStore.allItems.count + 1
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("ItemCell", forIndexPath: indexPath) as! ItemCell
        
        cell.updateLabels()
        
        if indexPath.row == itemStore.allItems.count {
            cell.nameLabel.text = "No More Items!"
            cell.nameLabel.textColor = UIColor.blueColor()
            cell.serialNumberLabel.alpha = 0
            cell.valueLabel.alpha = 0
        } else {
            let item = itemStore.allItems[indexPath.row]
            
            cell.nameLabel.text = item.name
            cell.serialNumberLabel.text = item.serialNumbner
            cell.valueLabel.text = "$\(item.valueInDollars)"
            cell.updateValueColor(item.valueInDollars)
            
        }
        
        return cell
    }
}
