//
//  DetailViewController.swift
//  JnJTracker
//
//  Created by Jay on 5/23/16.
//  Copyright © 2016 jay. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var detailDescriptionLabel: UILabel!
    @IBOutlet var deviceLbl: UILabel!
    @IBOutlet var osLbl: UILabel!
    @IBOutlet var manufacturerLbl: UILabel!
    @IBOutlet var checkinStatusLbl: UILabel!
    @IBOutlet var checkInOutBtn: UIButton!
    @IBAction func checkInBtnPressed(sender: AnyObject) {
//        TODO make a call to data manager and then to REST
//        let restCall = RestAPIService()
//        restCall.postDeviceAddUpdateCall(CallType.Update, parameter: self.deviceDetail!)
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