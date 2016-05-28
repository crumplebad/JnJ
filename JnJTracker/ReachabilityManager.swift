//
//  ReachabilityManager.swift
//  JnJTracker
//
//  Created by Jay on 5/27/16.
//  Copyright © 2016 jay. All rights reserved.
//

import Foundation
import Reachability

protocol ReachabilityManagerDelegate: class {
    func refreshTable(sender:ReachabilityManager)
}

class ReachabilityManager  {
    
    static let instance = ReachabilityManager()
    
    weak var delegate: ReachabilityManagerDelegate?
    var gReachability: Reachability? = nil
    var isReachable: Bool = false
    
    func start()  {
        
        let reachability: Reachability
        do {
            reachability = try Reachability.reachabilityForInternetConnection()
            gReachability = reachability
        } catch {
            print("Unable to create Reachability")
            return
        }
        
        reachability.whenReachable = { reachability in
            // this is called on a background thread, but UI updates must
            // be on the main thread, like this:
            if reachability.isReachableViaWiFi() {
                self.isReachable = true
                self.syncOfflineDataToServer()
                print("Reachable background threadvia WiFi")
            }
            
            dispatch_async(dispatch_get_main_queue()) {
                if reachability.isReachableViaWiFi() {
                    self.isReachable = true
                    print("Reachable via WiFi")
                } else {
                    print("Reachable via Cellular")
                }
            }
        }
        reachability.whenUnreachable = { reachability in
            // this is called on a background thread, but UI updates must
            // be on the main thread, like this:
            dispatch_async(dispatch_get_main_queue(),
                           {
                            self.isReachable = false
                            print("Not reachable")
                            let alertController = UIAlertController(title: "Network Error", message: "Network Connection Lost ", preferredStyle: .Alert)
                            let alertAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Destructive) { alert in
                                alertController.dismissViewControllerAnimated(true, completion: nil)
                            }
                            alertController.addAction(alertAction)
                            let vc: UIViewController  = (UIApplication.sharedApplication().keyWindow?.rootViewController)!;
                            vc.presentViewController(alertController, animated: true, completion: nil)
            })
        }
        
        do {
            try reachability.startNotifier()
        } catch {
            print("Unable to start notifier")
        }
    }
    
    func stop()  {
        if let gReachability = gReachability {
            gReachability.stopNotifier()
        }
    }
    
    func syncOfflineDataToServer()  {
        //show waiting screen
        
        let dataManager = DataManager()
        dataManager.syncOfflineData({
        (Void)->Void
        in
            //dismiss waiting screen
            print("All tasks! done back in Reachibility manager syncOfflineDataToServer")
            
            let alertController = UIAlertController(title: "Network Message", message: "All Offline data has been synced to the server.", preferredStyle: .Alert)
            let alertAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Destructive) { alert in
                alertController.dismissViewControllerAnimated(true, completion: nil)
            }
            alertController.addAction(alertAction)
            let vc: UIViewController  = (UIApplication.sharedApplication().keyWindow?.rootViewController)!;
            vc.presentViewController(alertController, animated: true, completion: nil)
            self.delegate?.refreshTable(self)
        })
        
    }
    
    
}