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
    
    var detailItem: Conference? {
        didSet {
            // Update the view.
            self.configureView()
        }
    }

    func configureView() {
        // Update the user interface for the detail item.
//        if let detail: Conference = self.detailItem {
//            if let label = self.eventNameLabel {
//                self.eventNameLabel.text = detail.name
//                self.eventDateLabel.text = "put the date here"
//            }
//        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        conferencesDao = appDelegate.conferencesDao!
        
        if let detail: Conference = self.detailItem {
            conferencesDao.getSessionsByConferenceId(detail.id!,sessionsHandler:  receivedSessions)
        }
    }
    
    func receivedSessions(sessions: NSArray) {
        for session in sessions {
            if let session = session as? Session {
                insertNewObject(session)
            }
        }
        
        // TODO: Sort sessionObjects by date and time
        // TODO: Determine the unique dates of the sessions and put it in a dateSections list
        
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
            self.tableView.reloadData()
        })
        
        NSLog("receivedSessions")
    }
    
    func insertNewObject(sender: AnyObject) {
        let y = sender as? Session
        
        if (y != nil) {
            sessionObjects.insertObject(sender, atIndex: 0)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Segues
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ShowSessionDetail" {
            if let indexPath = self.tableView.indexPathForSelectedRow() {
                let object = sessionObjects[indexPath.row] as! Session
                NSLog("showing session detail")
                (segue.destinationViewController as! SessionDetailViewController).detailItem = object
            }
        }
    }
    
    // MARK: - Table View
    
    // TODO: Format the section headers
    // TODO: Format the session cells
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sessionObjects.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("SessionCell", forIndexPath: indexPath) as! UITableViewCell
        
        // If date is 5/28, use section 0
        // Else use section 1
        
        let object = sessionObjects[indexPath.row] as! Session
        cell.textLabel!.text = object.startDateTime?.description
        return cell
    }

}
