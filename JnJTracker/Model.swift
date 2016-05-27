//
//  Model.swift
//  JnJTracker
//
//  Created by Jay on 5/24/16.
//  Copyright © 2016 jay. All rights reserved.
//

import Foundation

class Model {
    static let sharedInstance = Model()

    var devices: Devices?
    var addedDevices:[Device]?
    var deletedDevices:[Device]?
    var updatedDevices:[Device]?
    
}