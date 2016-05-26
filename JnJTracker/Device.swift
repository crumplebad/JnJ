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
    var id: Int?
    var device: String?
    var os: String?
    var manufacturer: String?
    var lastCheckedOutDate: String?
    var lastCheckedOutBy: String?
    var isCheckedOut: Bool?
    
    init(anObject: AnyObject?) {
        if let dict = anObject{
            if let id = dict["id"]{
                if let id = id {
                    self.id = id as? Int
                }
            }
            if let device = dict["device"] {
                if let device = device{
                    self.device = device as? String
                }
            }
            if let os = dict["os"] {
                if let os = os {
                    self.os = os as? String
                }
            }
            if let manufacturer = dict["manufacturer"] {
                if let manufacturer = manufacturer {
                    self.manufacturer = manufacturer as? String
                }
            }
            if let lastCheckedOutDate = dict["lastCheckedOutDate"] {
                if let lastCheckedOutDate = lastCheckedOutDate {
                    self.lastCheckedOutDate = lastCheckedOutDate as? String
                }
            }
            if let lastCheckedOutBy = dict["lastCheckedOutBy"] {
                if let lastCheckedOutBy = lastCheckedOutBy {
                    self.lastCheckedOutBy = lastCheckedOutBy as? String
                }
            }
            if let isCheckedOut = dict["isCheckedOut"] {
                if let isCheckedOut = isCheckedOut {
                    self.isCheckedOut = isCheckedOut as? Bool
                }
            }
        }
    }
}