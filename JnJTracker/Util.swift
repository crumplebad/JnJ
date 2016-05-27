//
//  Util.swift
//  JnJTracker
//
//  Created by Jay on 5/26/16.
//  Copyright © 2016 jay. All rights reserved.
//

import Foundation
import SystemConfiguration

class Util: NSObject {
    
    class func isOnline() -> Bool {
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(sizeofValue(zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        let defaultRouteReachability = withUnsafePointer(&zeroAddress) {
            SCNetworkReachabilityCreateWithAddress(nil, UnsafePointer($0))
        }
        var flags = SCNetworkReachabilityFlags()
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) {
            return false
        }
        let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
        let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
        return (isReachable && !needsConnection)
            return ReachabilityManager.instance.isReachable
    }
    
    class func RESTBaseURL() -> String {
        return "http://private-1cc0f-devicecheckout.apiary-mock.com"
    }
}