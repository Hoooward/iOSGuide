//
//  HistoryViewController.swift
//  iOSGuide
//
//  Created by Howard on 3/20/16.
//  Copyright © 2016 Howard. All rights reserved.
//

import UIKit

class HistoryViewCOntroller: UITableViewController {
    
    // MARK: Properties
    var tempStore: TempStore!
    
    // MARK: - Table view delegate
    
    // MARK: - Table view data source
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tempStore.allTemps.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        
        let temp = tempStore.allTemps[indexPath.row]
        
        cell.textLabel?.text = temp.fahrenheit
        cell.detailTextLabel?.text = temp.centigrade
        
        return cell
    }
    
}
