//
//  HYTextField.swift
//  iOSGuide
//
//  Created by Howard on 3/18/16.
//  Copyright © 2016 Howard. All rights reserved.
//

import UIKit

class HYTextField: UITextField {
    
    override func becomeFirstResponder() -> Bool {
        super.becomeFirstResponder()
        
        borderStyle = .Bezel
        layer.borderColor = UIColor.blueColor().CGColor
        return true
    }
    
    override func resignFirstResponder() -> Bool {
        super.resignFirstResponder()
        
        borderStyle = .Line
        layer.borderColor = UIColor.blackColor().CGColor
        
        return true
    }
}
