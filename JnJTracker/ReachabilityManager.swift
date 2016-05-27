//
//  ReachabilityManager.swift
//  JnJTracker
//
//  Created by Jay on 5/27/16.
//  Copyright © 2016 jay. All rights reserved.
//

import Foundation
import Reachability

class ReachabilityManager  {
    
    static let instance = ReachabilityManager()
    
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
            dispatch_async(dispatch_get_main_queue()) {
                if reachability.isReachableViaWiFi() {
                    self.isReachable = true
                    print("Reachable via WiFi")
                } else {
                    print("Reachable via Cellular")
                }

                
                // create a corresponding local notification
                let notification = UILocalNotification()
                notification.alertBody = "Todo Item Is Overdue" // text that will be displayed in the notification
                notification.alertAction = "open" // text that is displayed after "slide to..." on the lock screen - defaults to "slide to view"
                notification.fireDate = NSDate().dateByAddingTimeInterval(3.0)  // todo item due date (when notification will be fired)
                notification.soundName = UILocalNotificationDefaultSoundName // play default sound
                notification.userInfo = ["title": "test", "UUID": "99"] // assign a unique identifier to the notification so that we can retrieve it later
                
                UIApplication.sharedApplication().scheduleLocalNotification(notification)
                
//                let alertController = UIAlertController(title: "Network Message", message: "Network Connection Established ", preferredStyle: .Alert)
//                let alertAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Destructive) { alert in
//                    alertController.dismissViewControllerAnimated(true, completion: nil)
//                }
//                alertController.addAction(alertAction)
//                let vc: UIViewController  = (UIApplication.sharedApplication().keyWindow?.rootViewController)!;
//                vc.presentViewController(alertController, animated: true, completion: nil)

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
}