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
    
    init(aDictionary: Dictionary<String,String!>) {
        if let id = aDictionary["id"]{
            self.id = id
        }
        if let device = aDictionary["device"] {
            self.device = device
        }
        if let os = aDictionary["os"] {
            self.os = os
        }
        if let manufacturer = aDictionary["manufacturer"] {
            self.manufacturer = manufacturer
        }
        if let lastCheckedOutDate = aDictionary["lastCheckedOutDate"] {
            self.lastCheckedOutDate = lastCheckedOutDate
        }
        if let lastCheckedOutBy = aDictionary["lastCheckedOutBy"] {
            self.lastCheckedOutBy = lastCheckedOutBy
        }
        if let isCheckedOut = aDictionary["isCheckedOut"] {
            self.isCheckedOut = isCheckedOut
        }
    }
}