//
//  AddDeviceViewController.swift
//  JnJTracker
//
//  Created by Jay on 5/23/16.
//  Copyright © 2016 jay. All rights reserved.
//

import Foundation
import UIKit

protocol AddDeviceViewControllerDelegate: class {
    func addDeviceViewControllerDidCancel(sender: AddDeviceViewController)
    func addDeviceViewControllerDidSave(sender: AddDeviceViewController)
}

class AddDeviceViewController: UIViewController {
 
    weak var delegate: AddDeviceViewControllerDelegate?
    

    @IBAction func cancelPressed(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func donePressed(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func cancelToMasterViewController(segue:UIStoryboardSegue) {
        delegate?.addDeviceViewControllerDidCancel(self)
    }
    
    @IBAction func addDevice(segue:UIStoryboardSegue) {
        delegate?.addDeviceViewControllerDidCancel(self)
    }
}