//
//  ItemStore.swift
//  iOSGuide
//
//  Created by Howard on 3/13/16.
//  Copyright © 2016 Howard. All rights reserved.
//

import UIKit

class ItemStore2 {
    
    // MARK: Properties
    var expensiveItems = [Item]()
    var cheapItems = [Item]()
    
    lazy var allItems: [Item] = {
        return self.expensiveItems + self.cheapItems
        
    }()
    
    var sectionTitle = ["Cheap", "Expensive"]
    
    
    enum CategorizeItem {
        case OnlyHaveExpensiveItems
        case OnlyHaveCheapItems
        case BothExist
        case Nothing

    }
    
    var categorizeItems: CategorizeItem = .Nothing
    
    init() {
       
        for _ in 0..<0{
            createItem()
        }
//        checkItems()
    }

    func createItem() -> Item {
        let newItem = Item.init(random: true)
        if newItem.valueInDollars < 50 {
            cheapItems.append(newItem)
        } else {
            expensiveItems.append(newItem)
        }
        checkItemsState()
        return newItem
    }
    
    func checkItemsState() {
        if !cheapItems.isEmpty && !expensiveItems.isEmpty { categorizeItems = .BothExist }
        if !cheapItems.isEmpty && expensiveItems.isEmpty { categorizeItems = .OnlyHaveCheapItems }
        if !expensiveItems.isEmpty && cheapItems.isEmpty { categorizeItems = .OnlyHaveExpensiveItems }
        if cheapItems.isEmpty && expensiveItems.isEmpty { categorizeItems = .Nothing }
    }
    
}












