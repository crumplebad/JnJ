//
//  Devices.swift
//  JnJTracker
//
//  Created by Jay on 5/24/16.
//  Copyright © 2016 jay. All rights reserved.
//

import Foundation

class Devices: NSObject {

    var value = [Device]()
    
    init(anArray: [Dictionary<String,String!>]) {

        var array = [Device]()
        for device in anArray {
            let aDevice = Device(aDictionary: device)
            array.append(aDevice)
        }
        value = array
    }
}