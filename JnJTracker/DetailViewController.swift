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
    
    @IBAction func checkInBtnPressed(sender: AnyObject) {
    }
    var deviceDetail: Device? {
        didSet {
            // Update the view.
            self.configureView()
        }
    }

    func configureView() {
        // Update the user interface for the detail item.
        if let deviceDetail = self.deviceDetail {

            if let deviceLbl = self.deviceLbl {
//                label.text = detail.valueForKey("timeStamp")!.description
                if let device = deviceDetail.device {
                    
                    deviceLbl.text = "Device: "+device
                }
            }
            if let osLbl = self.osLbl {
                if let os = deviceDetail.os {
                    osLbl.text = "OS: "+os
                }
            }
            if let manufacturerLbl = self.manufacturerLbl {
                if let manufacturer = deviceDetail.manufacturer {
                    manufacturerLbl.text = "Manaufacturer: "+manufacturer
                }
            }
            if let checkinStatusLbl = self.checkinStatusLbl {
                if let lastCheckedOutBy = deviceDetail.lastCheckedOutBy {
                    if let lastCheckedOutDate = deviceDetail.lastCheckedOutDate {
                      checkinStatusLbl.text = "Last Checked Out: "+lastCheckedOutBy+" on "+lastCheckedOutDate
                    }
                } else {
                    checkinStatusLbl.text = "Checkin Status: Available"
                }
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.configureView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

