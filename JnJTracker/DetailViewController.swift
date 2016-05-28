//
//  DetailViewController.swift
//  JnJTracker
//
//  Created by Jay on 5/23/16.
//  Copyright © 2016 jay. All rights reserved.
//

import UIKit
import RealmSwift
import Realm

class DetailViewController: UIViewController {

    @IBOutlet weak var detailDescriptionLabel: UILabel!
    @IBOutlet var deviceLbl: UILabel!
    @IBOutlet var osLbl: UILabel!
    @IBOutlet var manufacturerLbl: UILabel!
    @IBOutlet var checkinStatusLbl: UILabel!
    @IBOutlet var checkInOutBtn: UIButton!
    @IBAction func checkInBtnPressed(sender: AnyObject) {
        if let deviceDeatil = self.deviceDetail{
            let realmDefault = RLMRealm.defaultRealm()
            realmDefault.beginWriteTransaction()

            if deviceDeatil.isCheckedOut {
                self.deviceDetail?.isCheckedOut = false
                self.deviceDetail?.lastCheckedOutBy = ""
                self.deviceDetail?.lastCheckedOutDate = ""
            } else {
                self.deviceDetail?.isCheckedOut = true
                self.deviceDetail?.lastCheckedOutBy = "Jay Gaonkar"
                let dateFormatter:NSDateFormatter = NSDateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss Z"
                self.deviceDetail?.lastCheckedOutDate = dateFormatter.stringFromDate(NSDate())
            }
            try! realmDefault.commitWriteTransaction()
        }
        let dataManager = DataManager()
        dataManager.updateDevice( self.deviceDetail!, completionhandler: {
//            [unowned self]
            (success:Bool)->Void in
            if success {
                self.configureView()
            } else {
//              DO NOTHING
            }
            })
        
    }

    var deviceDetail: Device? {
        didSet {
            self.configureView()
        }
    }

    func configureView() {
        if let deviceDetail = self.deviceDetail {

            if let deviceLbl = self.deviceLbl {
                    deviceLbl.text = "Device: "+deviceDetail.device
            }
            if let osLbl = self.osLbl {
                    osLbl.text = "OS: "+deviceDetail.os
            }
            if let manufacturerLbl = self.manufacturerLbl {
                    manufacturerLbl.text = "Manaufacturer: "+deviceDetail.manufacturer
            }
            if let checkinStatusLbl = self.checkinStatusLbl {
                if deviceDetail.isCheckedOut {
                checkinStatusLbl.text = "Last Checked Out: "+deviceDetail.lastCheckedOutBy+" on "+deviceDetail.lastCheckedOutDate
                    if let checkInOutBtn = self.checkInOutBtn{
                        checkInOutBtn.setTitle("Check In", forState: UIControlState.Normal)
                    }
                } else {
                    checkinStatusLbl.text = "Checkin Status: Available"
                    if let checkInOutBtn = self.checkInOutBtn{
                        checkInOutBtn.setTitle("Check Out", forState: UIControlState.Normal)
                    }
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}