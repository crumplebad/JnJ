//
//  Devices.swift
//  JnJTracker
//
//  Created by Jay on 5/24/16.
//  Copyright © 2016 jay. All rights reserved.
//

import Foundation

class Devices: NSObject {

    var value: Array<Device>
    
    func init(anArray: Array<AnyObject?>) {
        
        let array = Array()
        for device in anArray {
            device = 
            var aDevice: Device = Device(device)
            array.add
        }
        value = array
        
        return self;
    }
}