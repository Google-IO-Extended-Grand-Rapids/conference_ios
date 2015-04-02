//
//  ScheduleViewController.swift
//  ConferenceApp
//
//  Created by Dan McCracken on 4/2/15.
//  Copyright (c) 2015 GR OpenSource. All rights reserved.
//

import UIKit

class ScheduleViewController: UITableViewController {
    
    var sessionObjects = NSMutableArray()
    var conferencesDao: ConferencesDao!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        conferencesDao = appDelegate.conferencesDao!
        
        conferencesDao.getSessionsByConferenceId("conf_id", receivedSchedule)
        //conferencesDao.getConferenceById(0, receivedConferenceById)
        
        self.navigationItem.leftBarButtonItem = self.editButtonItem()
        
        let addButton = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: "insertNewObject:")
        self.navigationItem.rightBarButtonItem = addButton
    }
    
    func receivedSchedule(conferences: NSArray) {
        for conference in conferences {
            if let conference = conference as? Conference {
                insertNewObject(conference)
            }
        }
        
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
            self.tableView.reloadData()
        })
        
        NSLog("receivedConferences")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func insertNewObject(sender: AnyObject) {
        let y = sender as? Conference
        
        if (y != nil) {
            sessionObjects.insertObject(sender, atIndex: 0)
        } else {
            sessionObjects.insertObject(NSDate().description, atIndex: 0)
        }
        
        let indexPath = NSIndexPath(forRow: 0, inSection: 0)
        self.tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
    }
    
    // MARK: - Table View
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sessionObjects.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as UITableViewCell
        
        let object = sessionObjects[indexPath.row] as Conference
        cell.textLabel!.text = object.name
        return cell
    }

}
