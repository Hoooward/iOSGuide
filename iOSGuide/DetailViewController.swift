//
//  DetailViewController.swift
//  iOSGuide
//
//  Created by Howard on 3/18/16.
//  Copyright © 2016 Howard. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, UITextFieldDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    // MARK: Properties
    var item: Item! {
        didSet {
            navigationItem.title = item.name
        }
    }
    
    var imageStore: ImageStore!
    
    @IBOutlet weak var nameField: HYTextField!
    @IBOutlet weak var serialNumberField: HYTextField!
    @IBOutlet weak var valueField: HYTextField!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet var clearPhotoButton: UIBarButtonItem!
    @IBOutlet var imageView: UIImageView!
    
    var numberFormatter: NSNumberFormatter {
        let formatter = NSNumberFormatter()
        formatter.numberStyle = .DecimalStyle
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        return formatter
    }
    
    var dateFormatter: NSDateFormatter {
        let formatter = NSDateFormatter()
        formatter.dateStyle = .MediumStyle
        formatter.timeStyle = .NoStyle
        return formatter
    }
    
    
    @IBAction func backgroundTapped(sender: AnyObject) {
        view.endEditing(true)
    }
    // MARK: ViewController life cycle
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        nameField.text = item.name
        serialNumberField.text = item.serialNumbner
        valueField.text = numberFormatter.stringFromNumber(item.valueInDollars)
        dateLabel.text = dateFormatter.stringFromDate(item.dateCreated)

        datePicker.hidden = true
        
        let key = item.itemKey
        if let imageToDisplay = imageStore.imageForKey(key) {
            imageView.image = imageToDisplay
            imageView.hidden = false
        }
       
        
        updateClearPhotoButtonState()
        
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        view.endEditing(true)
        
        item.name = nameField.text ?? ""
        item.serialNumbner = serialNumberField.text
        
        if let valueText = valueField.text, value = numberFormatter.numberFromString(valueText) {
            item.valueInDollars = value.integerValue
        } else {
            item.valueInDollars = 0
        }
        item.dateCreated = dateFormatter.dateFromString(dateLabel.text!)!
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    // MARK: TextField Delegate
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    // MARK: IBAction

    @IBAction func changedDate(sender: AnyObject) {
        if datePicker.hidden {
            datePicker.alpha = 1
            UIView.animateWithDuration(0.5, animations: {
                self.datePicker.hidden = false
                self.imageView.hidden = false
            })
            
        } else {
            datePicker.alpha = 0
            UIView.animateWithDuration(0.5, animations: {
                self.datePicker.hidden = true
                
                if let _ = self.imageView.image {
                    
                } else {
                    self.imageView.hidden = true
                }

            })
        }
    }
    
    @IBAction func datePickerValueChanged(sender: UIDatePicker) {
        dateLabel.text = dateFormatter.stringFromDate(sender.date)
    }
    
    @IBAction func takePicture(sender: AnyObject) {
        
        let imagePicker = UIImagePickerController()
        if UIImagePickerController.isSourceTypeAvailable(.Camera) {
            imagePicker.sourceType = .Camera
        } else {
            imagePicker.sourceType = .PhotoLibrary
        }
        
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        
        presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func clearPhoto(sender: AnyObject) {
        imageView.image = nil
        
        if !imageView.hidden {
            UIView.animateWithDuration(0.5, animations: {
              self.imageView.hidden = true
            })
        }
      
        imageStore.deleteImageForKey(item.itemKey)
        updateClearPhotoButtonState()
        
    }
    
    func updateClearPhotoButtonState() {
        if let _ = imageView.image {
            clearPhotoButton.enabled = true
        } else {
            clearPhotoButton.enabled = false
        }
    }
    
    // MARK: ImagePickerController delegate
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        let image = info[UIImagePickerControllerEditedImage] as! UIImage
        
        imageStore.setImage(image, forKey: item.itemKey)
        imageView.image = image
        
        dismissViewControllerAnimated(true, completion: {
            
            UIView.animateWithDuration(0.5, animations: {
                
                self.imageView.hidden = false
                })
        })
    }
    
  
  
    
}













