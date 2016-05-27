//
//  Device.swift
//  JnJTracker
//
//  Created by Jay on 5/24/16.
//  Copyright © 2016 jay. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift
import Realm

class Device: Object {
    dynamic var id = 0
    dynamic var device = ""
    dynamic var os = ""
    dynamic var manufacturer = ""
    dynamic var lastCheckedOutDate = ""
    dynamic var lastCheckedOutBy = ""
    dynamic var isCheckedOut: Bool = false
    
//    convenience required init(anObject: AnyObject?) {
//        
//        self.init()
//
//        if let dict = anObject{
//             if let id = dict["id"]{
//                if let id = id {
//                    self.id = id as! Int
//                }
//            }
//            if let device = dict["device"]! {
//                    self.device = device as! String
//            }
//            if let os = dict["os"]! {
//                    self.os = os as! String
//            }
//            if let manufacturer = dict["manufacturer"]! {
//                    self.manufacturer = manufacturer as! String
//            }
//            if let lastCheckedOutDate = dict["lastCheckedOutDate"]! {
//                    self.lastCheckedOutDate = lastCheckedOutDate as! String
//            }
//            if let lastCheckedOutBy = dict["lastCheckedOutBy"]! {
//                    self.lastCheckedOutBy = lastCheckedOutBy as! String
//            }
//            if let isCheckedOut = dict["isCheckedOut"]! {
//                    self.isCheckedOut = isCheckedOut as! Bool
//            }
//        }
//        
//    }

}