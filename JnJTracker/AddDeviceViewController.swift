//
//  AddDeviceViewController.swift
//  JnJTracker
//
//  Created by Jay on 5/23/16.
//  Copyright © 2016 jay. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift

protocol AddDeviceViewControllerDelegate: class {
    func addDeviceViewControllerDidCancel(sender: AddDeviceViewController)
    func addDeviceViewControllerDidSave(sender: AddDeviceViewController)
}

class AddDeviceViewController: UIViewController {
 
    weak var delegate: AddDeviceViewControllerDelegate?
    var device:Device?
    var reloadTableFlag: Bool = false
    @IBOutlet var deviceTxtField: UITextField!
    @IBOutlet var osTxtField: UITextField!
    @IBOutlet var manufacturerTxtField: UITextField!

    @IBAction func cancelPressed(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func donePressed(sender: AnyObject) {
        if validateFields() {
            device = Device()
            device!.device = self.deviceTxtField.text!
            device!.os = self.osTxtField.text!
            device!.manufacturer = self.manufacturerTxtField.text!
            
            let dataManager = DataManager()
            dataManager.addDevice( device!, completionhandler: {
//                [unowned self, weak delegate = self.delegate!]
                (success:Bool)->Void in
                if success {
                    self.reloadTableFlag = true
                } else {
                    self.reloadTableFlag = false
                }
                self.delegate?.addDeviceViewControllerDidSave(self)
            })
        } else {
            let alertController = UIAlertController(title: "Field Validation Error", message: "All fields must be filled", preferredStyle: .Alert)
            let alertAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Destructive) { alert in
                alertController.dismissViewControllerAnimated(true, completion: nil)
            }
            alertController.addAction(alertAction)
            presentViewController(alertController, animated: true, completion: nil)
        }
    }

    func validateFields() -> Bool {
        
        if self.deviceTxtField.text!.isEmpty || self.osTxtField.text!.isEmpty || self.manufacturerTxtField.text!.isEmpty  {
            
            return false
        } else {
            return true
        }
    }
    
}