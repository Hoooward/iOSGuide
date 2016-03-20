//
//  ConversionViewController.swift
//  iOSGuide
//
//  Created by Howard on 3/6/16.
//  Copyright © 2016 Howard. All rights reserved.
//

import UIKit

class ConversionViewController: UIViewController, UITextFieldDelegate {
    // MARK: Properties
    @IBOutlet weak var celsiusLabel: UILabel!
    @IBOutlet weak var textField: UITextField!
    
    var numberFormater: NSNumberFormatter {
        let nf = NSNumberFormatter()
        nf.numberStyle = .DecimalStyle
        nf.minimumFractionDigits = 0
        nf.maximumFractionDigits = 1
        return nf
    }
    
    var celsiusValues: Double? {
        if let value = fahrenheiValue {
            return (value - 32) * (5 / 9)
        } else {
            return nil
        }
    }
    
    var fahrenheiValue: Double? {
        didSet {
            updateCelsiusLabel()
        }
    }
    
    // MARK: View lift cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Temp"
    }
    
    @IBAction func dismissMySelf() {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func updateCelsiusLabel() {
        if let value = celsiusValues {
            celsiusLabel.text = numberFormater.stringFromNumber(value)
        } else {
            celsiusLabel.text = "???"
        }
    }
    
    // MARK: Tap Gesuture for dismiss keyboard
    @IBAction func dismissKeyboard(sender: AnyObject) {
        textField.resignFirstResponder()
    }
    
    // MARK: UITextField delegate and funcation
    
    @IBAction func fahrenheiFieldEditingChanged(textField: UITextField) {
        
        if let text = textField.text, number = numberFormater.numberFromString(text) {
            fahrenheiValue = number.doubleValue
        } else {
            fahrenheiValue = nil
        }
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        
        print ("Current text: \(textField.text)")
        print ("replacement text: \(string)")
        
        
        let currentLocale = NSLocale.currentLocale()
        let decimalSeparator = currentLocale.objectForKey(NSLocaleDecimalSeparator) as! String
        let existingtextHasDecimlSeparator = textField.text?.rangeOfString(decimalSeparator)
        let replacementTextHasDecimlSpearator = string.rangeOfString(decimalSeparator)
        let letterCharacterSet = NSCharacterSet.letterCharacterSet()
        
        if string.rangeOfCharacterFromSet(letterCharacterSet) != nil {
            return false
        }
        
        if existingtextHasDecimlSeparator != nil && replacementTextHasDecimlSpearator != nil {
            return false
        } else {
            return true
        }
      
    }
    
}





















