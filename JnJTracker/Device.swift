//
//  Device.swift
//  JnJTracker
//
//  Created by Jay on 5/24/16.
//  Copyright © 2016 jay. All rights reserved.
//

import Foundation
import UIKit

struct Device {
    var id: String?
    var device: String?
    var os: String?
    var manufacturer: String?
    var lastCheckedOutDate: String?
    var lastCheckedOutBy: String?
    var isCheckedOut: String?
    
    init(anObject: AnyObject) {
        let dict = anObject as? Dictionary<String,String?>
        if let dict = dict {
            if let id = dict["id"]{
                self.id = id
            }
            if let device = dict["device"] {
                self.device = device
            }
            if let os = dict["os"] {
                self.os = os
            }
            if let manufacturer = dict["manufacturer"] {
                self.manufacturer = manufacturer
            }
            if let lastCheckedOutDate = dict["lastCheckedOutDate"] {
                self.lastCheckedOutDate = lastCheckedOutDate
            }
            if let lastCheckedOutBy = dict["lastCheckedOutBy"] {
                self.lastCheckedOutBy = lastCheckedOutBy
            }
            if let isCheckedOut = dict["isCheckedOut"] {
                self.isCheckedOut = isCheckedOut
            }
        }
    }
}