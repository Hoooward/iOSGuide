//
//  RootViewController.swift
//  iOSGuide
//
//  Created by Howard on 3/18/16.
//  Copyright © 2016 Howard. All rights reserved.
//

import UIKit

class RootViewController: UITableViewController {
    
    var itemStore: ItemStore!

    
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "Homepwner" {
            let navigationController = segue.destinationViewController as! UINavigationController
            let itemViewController = navigationController.topViewController as! ItemViewController
            itemViewController.itemStore = itemStore
        }
    }
    
}
