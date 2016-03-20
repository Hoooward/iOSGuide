//
//  ItemsViewController.swift
//  iOSGuide
//
//  Created by Howard on 3/13/16.
//  Copyright © 2016 Howard. All rights reserved.
//

import UIKit

class ItemsViewController2: UITableViewController {
    
    var itemStroe = ItemStore()
    
 
    // MARK: View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        /*
         *如果没有顶部的 NavigationBar, 可以使用下面的方法设置 tableview inset 的大小.
         *以此不让 tableview 的第一行内容与状态栏重叠
         */
        let _ = UIApplication.sharedApplication().statusBarFrame.height
        
        let insets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        tableView.contentInset = insets
        //设置 tableview inset 大小之后,屏幕右侧边缘的滑动指示器也需要响应的设置.
        tableView.scrollIndicatorInsets = insets
    }
    
    // View target Function
    @IBAction func addNewItem(sender: AnyObject) {
        
        // Make a new index path for the 0th section, lastrow
        
        let newItem = itemStroe.createItem()
        
        switch itemStroe.categorizeItems {
        case .Nothing: fallthrough
        case .OnlyHaveExpensiveItems:
            let index = itemStroe.expensiveItems.indexOf(newItem)
            let indexPath = NSIndexPath(forRow: index!, inSection: 0)
            tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
        case .OnlyHaveCheapItems:
            let index = itemStroe.cheapItems.indexOf(newItem)!
            let indexPath = NSIndexPath(forRow: index, inSection: 0)
            tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
        case .BothExist:
            
            let indexPath = NSIndexPath(forRow: 0, inSection: 0)
            let cell = tableView.cellForRowAtIndexPath(indexPath)
            let valueInDollar = cell?.detailTextLabel?.text!
            let valueArray = valueInDollar!.componentsSeparatedByString("$")
            print("value = \(valueArray)")
            print("newItem.ValueDollars = \(newItem.valueInDollars)")
            var section: Int
            
            if Int(valueArray.last!)! < 50 {
                section = 0
            } else {
                section = 1
       
            }
            
//            if itemStroe.cheapItems.count == 1 || itemStroe.expensiveItems.count == 1 {
//                if tableView.numberOfSections == 1 {
//                    tableView.beginUpdates()
//                    tableView.insertSections(NSIndexSet(index: 1), withRowAnimation: .Automatic)
//                    tableView.endUpdates()
//                }
//            }
//            
//            if newItem.valueInDollars < 50 {
//                let index = itemStroe.cheapItems.indexOf(newItem)!
//                let indexPath = NSIndexPath(forRow:index, inSection: section)
//                tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
//            } else {
//                let index = itemStroe.expensiveItems.indexOf(newItem)
//                let indexPath = NSIndexPath(forRow: index!, inSection: section)
//                tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
//            }
//            
            
//            
            if Int(valueArray.last!)! < 50 && newItem.valueInDollars < 50{
                let index = itemStroe.cheapItems.indexOf(newItem)
                let indexPath = NSIndexPath(forRow: index!, inSection: section)
                 tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
            } else if Int(valueArray.last!)! < 50  && newItem.valueInDollars >= 50 {
                let index = itemStroe.expensiveItems.indexOf(newItem)
                let indexPath = NSIndexPath(forRow: index!, inSection: section)
                tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
                
            } else if itemStroe.cheapItems.count == 1 || itemStroe.expensiveItems.count == 1 {
                if tableView.numberOfSections == 1 {
                    tableView.beginUpdates()
                    tableView.insertSections(NSIndexSet(index: 1), withRowAnimation: .Automatic)
                    tableView.endUpdates()
                }
                
            }
        }
        
    }
    
    @IBAction func toggleEditingMode(sender: AnyObject) {
        if editing {
            // change text of button to inform user of state
            sender.setTitle("Edit", forState: .Normal)
            
            // Turn off editing mode
            setEditing(false, animated: true)
        } else {
            // change text of button to inform user of state
            sender.setTitle("Done", forState: .Normal)
            
            // Enter editing mode
            setEditing(true, animated: true)
        }
    }
    
    // MARK: UITableView DataSource
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        switch itemStroe.categorizeItems {
        case .BothExist: return 2
        default: return 1
        }
        
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch itemStroe.categorizeItems {
        case .Nothing : return 0
        case .OnlyHaveCheapItems: return itemStroe.cheapItems.count
        case .OnlyHaveExpensiveItems: return itemStroe.expensiveItems.count
        case .BothExist:
            if section == 0 {
                return itemStroe.cheapItems.count
            }
            if section == 1 {
                return itemStroe.expensiveItems.count
            }
        
        }
        return 1
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        /**
        Creat an instance of UITableViewCell. with default appearance
        let cell = UITableViewCell(style: .Value1, reuseIdentifier: "UITableViewCell")
        */
        
        /*
         creat a new or recycled cell
        */
        let cell = tableView.dequeueReusableCellWithIdentifier("UITableViewCell", forIndexPath: indexPath)
        
        var item: Item
        
        switch itemStroe.categorizeItems {
            
        case .Nothing:
            cell.textLabel?.text = "Nothing"
            return cell
        case .OnlyHaveCheapItems:
            item = itemStroe.cheapItems[indexPath.row]
            cell.textLabel?.text = item.name
            cell.detailTextLabel?.text = "$\(item.valueInDollars)"
            return cell
        case .OnlyHaveExpensiveItems:
            item = itemStroe.expensiveItems[indexPath.row]
            cell.textLabel?.text = item.name
            cell.detailTextLabel?.text = "$\(item.valueInDollars)"
            return cell
        case .BothExist:
            let section = indexPath.section
            if section == 0 {
                item = itemStroe.cheapItems[indexPath.row]
                cell.textLabel?.text = item.name
                cell.detailTextLabel?.text = "$\(item.valueInDollars)"
                return cell
            }
            if section == 1 {
                item = itemStroe.expensiveItems[indexPath.row]
                cell.textLabel?.text = item.name
                cell.detailTextLabel?.text = "$\(item.valueInDollars)"
                return cell
            }
        }
        
        return cell
    }
    
    // MARK: UITableView Delegate
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch itemStroe.categorizeItems {
            
        case .Nothing: return "Nothing"
        case .OnlyHaveCheapItems: return itemStroe.sectionTitle[section]
        case .OnlyHaveExpensiveItems : return itemStroe.sectionTitle[section]
        case .BothExist: return itemStroe.sectionTitle[section]
    
        }
    }
    
}















