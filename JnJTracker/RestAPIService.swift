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
    func getDevicesCall(completionHandler:(Devices)->Void) {
    // GET
        let devicesEndPoint: String = Util.RESTBaseURL()+"/devices"
        Alamofire.request(.GET, devicesEndPoint)
            .responseJSON { response in
                guard response.result.error == nil else {
                    print("error calling GET to fetch devices")
                    print(response.result.error!)
                    return
                }
                guard let value = response.result.value else {
                    print("no result data received when calling GET to fetch devices")
                    return
                }
                let devicesJson = JSON(value)
                guard let deviceName = devicesJson[0]["device"].string else {
                        print("error parsing devices")
                        return
                }
                print("Testing parse Device is: " + deviceName)
                completionHandler(Devices(json: devicesJson))
        }
    }
    
    func postDeviceAddUpdateCall( callType: CallType, parameter: Device, completionHandler:(aDevice:Device?, success: Bool)->Void) {
        //POST
        var endPoint: String = ""
        var param = [String: AnyObject]()
        
        if callType == .Add {
            endPoint = Util.RESTBaseURL()+"/devices"
                param = ["device": parameter.device, "os": parameter.os, "manufacturer":parameter.manufacturer]
        } else if callType == .Update {
                endPoint = Util.RESTBaseURL()+"/devices/\(parameter.id)"
                    if parameter.isCheckedOut {
                        param = ["lastCheckedOutDate":parameter.lastCheckedOutDate,"lastCheckedOutBy":parameter.lastCheckedOutBy,"isCheckedOut": true]
                    } else {
                        param = ["isCheckedOut": false]
                    }
        }
        
        Alamofire.request(.POST, endPoint, parameters: param, encoding: .JSON)
            .responseJSON { response in
                guard response.result.error == nil else {
                    
                     let statusCode = (response.response?.statusCode)!
                     if statusCode == 200 {
                        //call completion block for success
                        completionHandler(aDevice: nil, success: true)
                     } else {
                        
                        print("error calling POST ")
                        print(response.result.error!)
                    }
                    return
                }
                
                guard let value = response.result.value else {
                    print("no result data received when calling GET ")
                    return
                }
                let device = self.returnDeviceFromJSON(JSON(value))
                if callType == .Add {
                    print("The added device details are: " + device.description)
                    completionHandler(aDevice: device, success: true)
                } else {
//                    print("The modified device details are: " + device.description)
                    completionHandler(aDevice: nil, success: true)
                }
        }
    }
    
    func deleteDeviceCall(parameter: Device, completionHandler: (success: Bool)->Void) {
        //DELETE
        var endPoint: String = ""
            endPoint = Util.RESTBaseURL()+"/devices/\(parameter.id)"
        
        Alamofire.request(.DELETE, endPoint)
            .responseJSON { response in
                guard response.result.error == nil else {
                    print("error calling DELETE ")
                    print(response.result.error!)
                    completionHandler(success: false)
                    return
                }
                completionHandler(success: true)

        }
    }
    
    func returnDeviceFromJSON(deviceJSON: JSON) -> Device {
        let aDevice: Device = Device()
        if let  id = deviceJSON["id"].int {
            aDevice.id = id
        }
        if let device = deviceJSON["device"].string {
            aDevice.device = device
        }
        if let os = deviceJSON["os"].string {
            aDevice.os = os
        }
        if let manufacturer = deviceJSON["manufacturer"].string {
            aDevice.manufacturer = manufacturer
        }
        if let lastCheckedOutDate = deviceJSON["lastCheckedOutDate"].string {
            aDevice.lastCheckedOutDate = lastCheckedOutDate
        }
        if let lastCheckedOutBy = deviceJSON["lastCheckedOutBy"].string {
            aDevice.lastCheckedOutBy = lastCheckedOutBy
        }
        if let isCheckedOut =  deviceJSON["isCheckedOut"].bool {
            aDevice.isCheckedOut = isCheckedOut
        }
        aDevice.objectStatus = "normal"

        
        return aDevice
    }
}