//
//  ItemStore.swift
//  iOSGuide
//
//  Created by Howard on 3/16/16.
//  Copyright © 2016 Howard. All rights reserved.
//

import UIKit

class ItemStore {
    
    var allItems = [Item]()
    
    init() {
        for _ in 0..<0 {
            creatItems()
        }
        if let archivedItems = NSKeyedUnarchiver.unarchiveObjectWithFile(itemArchiveURL.path!) as? [Item] {
            allItems += archivedItems
        }
            
        
    }
    
    func creatItems() -> Item {
        let newItem = Item.init(random: true)
        allItems.append(newItem)
        return newItem
    }
    
    func removeItem(item: Item) {
        if let index = allItems.indexOf(item) {
            allItems.removeAtIndex(index)
        }
    }
    
    func moveItemAtIndex(fromIndex: Int, toIndex: Int) {
        
        if fromIndex == toIndex {
            return
        }
        
        guard fromIndex != toIndex else {
            return
        }
        
        let moveItem = allItems[fromIndex]
        
        allItems.removeAtIndex(fromIndex)
        
        
        
        allItems.insert(moveItem, atIndex: toIndex)
    }
    
    // MARK: - itemArchiveURL
    private var itemArchiveURL: NSURL = {
       let documentsDirectorys = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)
        let documentURl = documentsDirectorys.first!
        return documentURl.URLByAppendingPathComponent("item.archive")
        
    }()
    
    func saveChanges() -> Bool {
        print("Saving items to :\(itemArchiveURL.path!)")
        return NSKeyedArchiver.archiveRootObject(allItems, toFile: itemArchiveURL.path!)
    }
    
    
}







