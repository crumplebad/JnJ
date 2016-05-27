//
//  DataManager.swift
//  JnJTracker
//
//  Created by Jay on 5/24/16.
//  Copyright © 2016 jay. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift

class DataManager {

    func getDeviceData(completionhandler: (Void)->Void) {
        if Util.isOnline() {
            let restCall = RestAPIService()
            restCall.getDevicesCall({
                (devices:Devices)->Void in
                Model.sharedInstance.devices = devices
                //save to local
                let realm = try! Realm()
                try! realm.write {
                    realm.delete(realm.objects(Device))
                    for singleDevice in devices.valueArray {
                        realm.add(singleDevice)
                    }
                }
                completionhandler()
            })
        } else {
            //else read from local
            let devices: Devices = Devices()
            let aValueArray = try! Realm().objects(Device)
            var anArray = [Device]()
            for aDevice in aValueArray {
                anArray.append(aDevice)
            }
            devices.valueArray = anArray
            Model.sharedInstance.devices = devices
            completionhandler()
        }
    }
    
    
    func addDevice(aDevice: Device, completionhandler: (Bool)->Void) {
        if Util.isOnline() {
            let restCall = RestAPIService()
            restCall.postDeviceAddUpdateCall(CallType.Add, parameter: aDevice, completionHandler: {
                (retDevice: Device, success: Bool)->Void in

//            Write to local
                let realm = try! Realm()
                try! realm.write {
                    realm.add(retDevice)
                }
                Model.sharedInstance.devices?.valueArray.append(retDevice)
                completionhandler(success)
            })
        } else {
//            TODO
//            add to local
            completionhandler(true)
        }
    }
    
//      TODO change it to update device
    func updateDevice(aDevice: Device, completionhandler: (Bool)->Void) {
        if Util.isOnline() {
//            update online
//            let restCall = RestAPIService()
//             store local and Model
             completionhandler(true)
        } else {
            //update local and Model
            completionhandler(true)
        }
    }
    //TODO change it to delete device
    func deleteDevice(aDevice: Device, completionhandler: (Bool)->Void) {
        if Util.isOnline() {
//                delete online
//            let restCall = RestAPIService()
//            delete local and Model
                completionhandler(true)
        } else {
            //delete to local and Model
            completionhandler(true)
        }
    }
    
}

//        TESTING PURPOSE ONLY
//            let someObj: AnyObject? = self.readJSONFromFile("device")
//            if let data = (someObj as? NSArray) as Array? {
//                let devices: Devices = Devices(anArray: data)
//
//                let realm = try! Realm()
//                try! realm.write {
//                    for device: Device in devices.valueArray {
//                        realm.add(device)
//                    }
//                }
//
//                return devices;
//            }
    
//       TESTING PURPOSE ONLY
//    func readJSONFromFile(fileName: String?) -> AnyObject?{
//        
//        if let path = NSBundle.mainBundle().pathForResource(fileName, ofType: "json")
//        {
//            do{
//                if let jsonData = NSData(contentsOfFile:path)
//                {
//                    
//                    if let jsonResult: AnyObject = try NSJSONSerialization.JSONObjectWithData(jsonData, options: NSJSONReadingOptions.MutableContainers)
//                    {
//
//                        return jsonResult ;
//                    } else {
//                        return nil;
//                    }
//                } else {
//                    return nil;
//                }
//            }
//            catch let error as NSError {
//                print(error.localizedDescription)
//                return nil;
//            }
//        } else {
//            return nil;
//        }
//    }