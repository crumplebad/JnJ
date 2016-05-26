//
//  RestAPIService.swift
//  JnJTracker
//
//  Created by Jay on 5/25/16.
//  Copyright © 2016 jay. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

enum CallType {
    case Add
    case Update
}

class RestAPIService: NSObject {
    
    // MARK: Using Alamofire
    func getCall() {
    // GET
        let devicesEndPoint: String = "http://private-1cc0f-devicecheckout.apiary-mock.com/devices"
        Alamofire.request(.GET, devicesEndPoint)
            .responseJSON { response in
                guard response.result.error == nil else {
                    // got an error in getting the data, need to handle it
                    print("error calling GET to fetch devices")
                    print(response.result.error!)
                    return
                }
                
                guard let value = response.result.value else {
                    print("no result data received when calling GET to fetch devices")
                    return
                }
                let devices = JSON(value)
                print("The Devices are: " + devices.description)
                guard let deviceName = devices[0]["device"].string else {
                    print("error parsing devices")
                    return
                }
                // to access a field:
                print("The title is: " + deviceName)
        }
    }
    
    func postCall( callType: CallType, parameter: Device) {
        //POST
        var endPoint: String = ""
        var param = [String: AnyObject]()
        
        if callType == .Add {
            endPoint = "http://private-1cc0f-devicecheckout.apiary-mock.com/devices"
                param = ["device": parameter.device!, "os": parameter.os!, "manufacturer":parameter.manufacturer!]
        } else if callType == .Update {
            if let deviceId = parameter.id {
                endPoint = "http://private-1cc0f-devicecheckout.apiary-mock.com/devices/\(deviceId)"
                if let isChecked = parameter.isCheckedOut {
                    if isChecked {
                        param = ["lastCheckedOutDate":parameter.lastCheckedOutDate!,"lastCheckedOutBy":parameter.lastCheckedOutBy!,"isCheckedOut": true]
                    } else {
                        param = ["isCheckedOut": false]
                    }
                }
            }
        }
        
        Alamofire.request(.POST, endPoint, parameters: param, encoding: .JSON)
            .responseJSON { response in
                guard response.result.error == nil else {
                    // got an error in getting the data, need to handle it
                    print("error calling POST ")
                    print(response.result.error!)
                    return
                }
                
                guard let value = response.result.value else {
                    print("no result data received when calling GET ")
                    return
                }
                let device = JSON(value)
                if callType == .Add {
                    print("The added device details are: " + device.description)
                } else {
                    print("The modified device details are: " + device.description)
                }
        }
    }
    
    func deleteCall(parameter: Device) {
        //DELETE
        var endPoint: String = ""
        if let deviceId = parameter.id {
            endPoint = "http://private-1cc0f-devicecheckout.apiary-mock.com/devices/\(deviceId)"
        }
        
        Alamofire.request(.DELETE, endPoint)
            .responseJSON { response in
                guard response.result.error == nil else {
                    // got an error in getting the data, need to handle it
                    print("error calling DELETE ")
                    print(response.result.error!)
                    return
                }
                print("DELETE ok")
        }
    }
}