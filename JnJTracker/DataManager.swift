//
//  DataManager.swift
//  JnJTracker
//
//  Created by Jay on 5/24/16.
//  Copyright © 2016 jay. All rights reserved.
//

import Foundation
import UIKit

class DataManager {

    func getDeviceData() -> Devices? {
        
        let someObj: AnyObject? = self.readJSONFromFile("device")
        if let data = (someObj as? NSArray) as Array? {
            let deviceData: Devices = Devices(anArray: data)

            return deviceData;
        }
    
        return nil;
    }
    
    func readJSONFromFile(fileName: String?) -> AnyObject?{
        
        if let path = NSBundle.mainBundle().pathForResource(fileName, ofType: "json")
        {
            do{
                if let jsonData = NSData(contentsOfFile:path)
                {
                    
                    if let jsonResult: AnyObject = try NSJSONSerialization.JSONObjectWithData(jsonData, options: NSJSONReadingOptions.MutableContainers)
                    {

                        return jsonResult ;
                    } else {
                        return nil;
                    }
                } else {
                    return nil;
                }
            }
            catch let error as NSError {
                print(error.localizedDescription)
                return nil;
            }
        } else {
            return nil;
        }
    }
}

