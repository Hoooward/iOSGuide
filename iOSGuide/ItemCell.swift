//
//  ItemCell.swift
//  iOSGuide
//
//  Created by Howard on 3/17/16.
//  Copyright © 2016 Howard. All rights reserved.
//

import UIKit

class ItemCell: UITableViewCell {
    
    // MARK: Properties
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var serialNumberLabel: UILabel!
    @IBOutlet var valueLabel: UILabel!
    
    func updateLabels() {
        let bodyFont = UIFont.preferredFontForTextStyle(UIFontTextStyleBody)
        nameLabel.font = bodyFont
        valueLabel.font = bodyFont
        
        let captionFont = UIFont.preferredFontForTextStyle(UIFontTextStyleCaption1)
        serialNumberLabel.font = captionFont
    }
    
    func updateValueColor(valueInDollars: Int) {
        var valueColor: UIColor
        if valueInDollars < 50 {
            valueColor = UIColor.greenColor()
        } else {
            valueColor = UIColor.redColor()
        }
        nameLabel.textColor = UIColor.blackColor()
        
        valueLabel.textColor = valueColor
        valueLabel.alpha = 1
        serialNumberLabel.alpha = 1
    }
    
}
