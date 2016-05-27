//
//  Devices.swift
//  JnJTracker
//
//  Created by Jay on 5/24/16.
//  Copyright © 2016 jay. All rights reserved.
//

import Foundation
import SwiftyJSON

class Devices: NSObject {

    var valueArray = [Device]()
    
    init(json: JSON) {

        var array = [Device]()
        let arrayJson = json.arrayValue
        for item in arrayJson {
            let aDevice = Device()
            if let  id = item["id"].int {
                aDevice.id = id
            } 
            if let device = item["device"].string {
                aDevice.device = device
            }
            if let os = item["os"].string {
                aDevice.os = os
            }
            if let manufacturer = item["manufacturer"].string {
                aDevice.manufacturer = manufacturer
            }
            if let lastCheckedOutDate = item["lastCheckedOutDate"].string {
                aDevice.lastCheckedOutDate = lastCheckedOutDate
            }
            if let lastCheckedOutBy = item["lastCheckedOutBy"].string {
                aDevice.lastCheckedOutBy = lastCheckedOutBy
            }
            if let isCheckedOut =  item["isCheckedOut"].bool {
                aDevice.isCheckedOut = isCheckedOut
            }
                aDevice.objectStatus = "normal"
            
            array.append(aDevice)
        }
        valueArray = array
    }
    
    override init() {
        super.init()
    }
}