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
import Realm

class DataManager {

    func getDevicesData(completionhandler: (Void)->Void) {
        if Util.isOnline()
        {
            let restCall = RestAPIService()
            restCall.getDevicesCall({
                (devices:Devices)->Void in
                Model.sharedInstance.devices = devices

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
            //TODO this bad if there is no data in DB and app is offline
            syncModelWithDB()
            completionhandler()
        }
    }
    
    func addDevice(aDevice: Device, completionhandler: (Bool)->Void) {
        if Util.isOnline() {
            let restCall = RestAPIService()
            restCall.postDeviceAddUpdateCall(CallType.Add, parameter: aDevice, completionHandler: {
                [unowned self]
                (retDevice: Device?, success: Bool)->Void
                in
                if let retDevice = retDevice {
                    let realmDefault = RLMRealm.defaultRealm()
                    realmDefault.beginWriteTransaction()
                    retDevice.objectStatus = "normal"
                    try! realmDefault.commitWriteTransaction()
                    self.addDeviceToDB(retDevice)
                    self.syncModelWithDB()
                }
                completionhandler(success)
            })
        } else {
            let realmDefault = RLMRealm.defaultRealm()
            realmDefault.beginWriteTransaction()
            aDevice.objectStatus = "added"
            try! realmDefault.commitWriteTransaction()
            addDeviceToDB(aDevice)
            syncModelWithDB()
            completionhandler(true)
        }
    }
    
    func updateDevice(aDevice: Device, completionhandler: (Bool)->Void) {
        if Util.isOnline() {
            let restCall = RestAPIService()
            restCall.postDeviceAddUpdateCall(CallType.Update, parameter: aDevice,completionHandler: {
                [unowned self]
                (retDevice: Device?, success: Bool)->Void //retDevice is nil and not to be used.
                in
                if success {
                    let realmDefault = RLMRealm.defaultRealm()
                    realmDefault.beginWriteTransaction()
                    aDevice.objectStatus = "normal"
                    try! realmDefault.commitWriteTransaction()
                    self.updateObjectInDBWith(aDevice)
                    self.syncModelWithDB()
                }
                completionhandler(success)
            })
        } else {
            let realmDefault = RLMRealm.defaultRealm()
            realmDefault.beginWriteTransaction()
            aDevice.objectStatus = "updated"
            try! realmDefault.commitWriteTransaction()
            updateObjectInDBWith(aDevice)
            syncModelWithDB()
            completionhandler(true)
        }
    }

    func deleteDevice(aDevice: Device, row: Int, completionhandler: (Bool)->Void) {
        if Util.isOnline() {
            let restCall = RestAPIService()
            restCall.deleteDeviceCall(aDevice, completionHandler: {
                [unowned self]
                (success: Bool)->Void
                in
                if success {
                    self.deleteDeviceInDB(aDevice)
                    self.syncModelWithDB()
//                    Model.sharedInstance.devices?.valueArray.removeAtIndex(row)
                }
                completionhandler(success)
            })
        } else {
            let realmDefault = RLMRealm.defaultRealm()
            realmDefault.beginWriteTransaction()
            aDevice.objectStatus = "deleted"
            try! realmDefault.commitWriteTransaction()
            updateObjectInDBWith(aDevice)
            syncModelWithDB()
            completionhandler(true)
        }
    }
//      MARK: DB methods (should be reafactored)
    func addDeviceToDB(device: Device) {
        let realm = try! Realm()
        try! realm.write {
            realm.add(device)
        }
    }
    
    func updateObjectInDBWith(object: Device)  {
        let realm = try! Realm()
        let objectsToUpdate = realm.objects(Device).filter(NSPredicate(format:"id = \(object.id)"))
        if objectsToUpdate.count == 1 {
            let deviceToUpdate = objectsToUpdate[0]
            let realmDefault = RLMRealm.defaultRealm()
            realmDefault.beginWriteTransaction()
            deviceToUpdate.device = object.device
            deviceToUpdate.os = object.os
            deviceToUpdate.manufacturer = object.manufacturer
            deviceToUpdate.lastCheckedOutDate = object.lastCheckedOutDate
            deviceToUpdate.lastCheckedOutBy = object.lastCheckedOutBy
            deviceToUpdate.isCheckedOut = object.isCheckedOut
            deviceToUpdate.objectStatus = object.objectStatus
            try! realmDefault.commitWriteTransaction()
            
        }
    }
    
    func deleteDeviceInDB(device: Device) {
        let realm = try! Realm()
        let aValueArray = realm.objects(Device).filter(NSPredicate(format:"id = \(device.id)"))
        try! realm.write {
            realm.delete(aValueArray)
        }
    }

    func syncModelWithDB() {
        let devices: Devices = Devices()
        let aValueArray = try! Realm().objects(Device).filter(NSPredicate(format:"objectStatus != 'deleted'"))
        var anArray = [Device]()
        for aDevice in aValueArray {
            anArray.append(aDevice)
        }
        devices.valueArray = anArray
        Model.sharedInstance.devices = devices
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