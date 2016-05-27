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
    
    func postDeviceAddUpdateCall( callType: CallType, parameter: Device, completionHandler:(aDevice:Device, success: Bool)->Void) {
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
                let device = JSON(value)
                if callType == .Add {
                    print("The added device details are: " + device.description)
                } else {
                    print("The modified device details are: " + device.description)
                }
        }
    }
    
    func deleteDeviceCall(parameter: Device) {
        //DELETE
        var endPoint: String = ""
            endPoint = Util.RESTBaseURL()+"/devices/\(parameter.id)"
        
        Alamofire.request(.DELETE, endPoint)
            .responseJSON { response in
                guard response.result.error == nil else {
                    print("error calling DELETE ")
                    print(response.result.error!)
                    return
                }
                print("DELETE ok")
        }
    }
}