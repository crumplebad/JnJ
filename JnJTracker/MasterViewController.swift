//
//  MasterViewController.swift
//  JnJTracker
//
//  Created by Jay on 5/23/16.
//  Copyright © 2016 jay. All rights reserved.
//

import UIKit
import Reachability
import RealmSwift

class MasterViewController: UITableViewController, AddDeviceViewControllerDelegate {

    var detailViewController: DetailViewController? = nil
    var dataSource: [Device] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        print(Realm.Configuration.defaultConfiguration.fileURL!)
        let dataManager = DataManager()
        dataManager.getDevicesData({
            [weak self]
            (Void) -> Void  in
            self?.dataSource = Model.sharedInstance.devices!.valueArray
            self?.tableView.reloadData()
        })
        if let split = self.splitViewController {
            let controllers = split.viewControllers
            self.detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? DetailViewController
        }
    }

    override func viewWillAppear(animated: Bool) {
        self.clearsSelectionOnViewWillAppear = self.splitViewController!.collapsed
        super.viewWillAppear(animated)
        self.tableView.reloadData()
    }

    // MARK: - Segues

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetails" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let object = self.dataSource[indexPath.row]
                let controller = (segue.destinationViewController as! UINavigationController).topViewController as! DetailViewController
                controller.deviceDetail = object
                controller.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem()
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        } else if (segue.identifier == "addDevice") {
            // pass data to next view
            let controller = (segue.destinationViewController as! UINavigationController).topViewController as! AddDeviceViewController
            controller.delegate = self
        }
    }

    // MARK: - Table View

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return self.dataSource.count ?? 0
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("deviceCell", forIndexPath: indexPath)
        self.configureCell(cell, atIndexPath: indexPath)
        return cell
    }

    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {

        return true
    }

    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            
            let alert = UIAlertController(title: "Alert", message: "This device will be deleted.", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
            
            alert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: { action in
                switch action.style{
                case .Default:
                    print("Delete device.")
                    self.deleteDeviceAtIndex(indexPath)
                case .Cancel:
                    print("Do Nothing")
                case .Destructive:
                    print("destructive")
                }
            }))
        }
    }

    func configureCell(cell: UITableViewCell, atIndexPath indexPath: NSIndexPath) {
        if let aDevice:Device = self.dataSource[indexPath.row] as Device {
            
                cell.textLabel!.text = aDevice.device+" - "+aDevice.os
                if aDevice.isCheckedOut {
                        cell.detailTextLabel?.text = "Checked out by "+aDevice.lastCheckedOutBy
                } else {
                    cell.detailTextLabel?.text = "Available"
                }
        }
    }
    
    /*
     // Implementing the above methods to update the table view in response to individual changes may have performance implications if a large number of changes are made simultaneously. If this proves to be an issue, you can instead just implement controllerDidChangeContent: which notifies the delegate that all section and object changes have been processed.
     
     func controllerDidChangeContent(controller: NSFetchedResultsController) {
         // In the simplest, most efficient, case, reload the table view.
         self.tableView.reloadData()
     }
     */
    func deleteDeviceAtIndex(indexPath: NSIndexPath) {

        let dataManager = DataManager()
        
        dataManager.deleteDevice(self.dataSource[indexPath.row], row: indexPath.row, completionhandler: {
            [unowned self]
            (success: Bool) -> Void  in
                if success {
                    self.dataSource = Model.sharedInstance.devices!.valueArray
                    self.tableView.reloadData()
                }
            })
    }
    
    //MARK: AddDevice Delegate Methods
    
    func addDeviceViewControllerDidCancel(sender: AddDeviceViewController) {
        //DO nothing
    }
    
    
    func addDeviceViewControllerDidSave(sender: AddDeviceViewController) {
        self.dismissViewControllerAnimated(true, completion: nil)
        if sender.reloadTableFlag {
            self.dataSource = Model.sharedInstance.devices!.valueArray
            self.tableView.reloadData()
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

