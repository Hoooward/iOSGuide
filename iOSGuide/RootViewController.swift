//
//  RootViewController.swift
//  iOSGuide
//
//  Created by Howard on 3/18/16.
//  Copyright © 2016 Howard. All rights reserved.
//

import UIKit

protocol SegueHandlerType {
    typealias SegueIdentifier: RawRepresentable
}

extension SegueHandlerType where
    Self: UIViewController,
    SegueIdentifier.RawValue == String {
    
    func performSegueWithIdentifier(segueIdentifier: SegueIdentifier, sender: AnyObject?) {
        performSegueWithIdentifier(segueIdentifier.rawValue, sender: sender)
    }
    
    func segueIdentifierForSegue(segue: UIStoryboardSegue) -> SegueIdentifier {
        guard let identifier = segue.identifier,
            segueIdentifier = SegueIdentifier(rawValue: identifier) else {
                fatalError("Invalid segue identifier \(segue.identifier)")
        }
        
        return segueIdentifier
    }
}

extension NSURL {
    
     static func archiveURLWithEndPathComponent(name: String) -> NSURL {
        let documentDirectory = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)
        let documentURL = documentDirectory.first!
        
        return documentURL.URLByAppendingPathComponent("\(name).archive")
    }
}


class RootViewController: UITableViewController, SegueHandlerType {
    
    enum SegueIdentifier: String {
        case Homepwner = "Homepwner"
        case Temp = "ShowTemp"
    }
    
    var itemStore: ItemStore!
    var tempStore: TempStore!
    
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        switch segueIdentifierForSegue(segue) {
        case .Homepwner:
            let navigationController = segue.destinationViewController as! UINavigationController
            let itemViewController = navigationController.topViewController as! ItemViewController
            itemViewController.itemStore = itemStore
        case .Temp:
            let tabBarController = segue.destinationViewController as! UITabBarController

            let navigationController = tabBarController.viewControllers?.first as! UINavigationController
            let conversionViewController = navigationController.topViewController as! ConversionViewController
            conversionViewController.tempStore = tempStore
            
        }
        
    }
    
}
