//
//  ScheduleViewController.swift
//  ConferenceApp
//
//  Created by Dan McCracken on 4/2/15.
//  Copyright (c) 2015 GR OpenSource. All rights reserved.
//

import UIKit

class ScheduleViewController: UITableViewController {
    
    var sessionObjects = [Session]()
    var conferencesDao: ConferencesDao!
    var dateSet: Set<String> = []
    
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
            conferencesDao.getSessionsByConferenceId(detail.id!,sessionsHandler: receivedSessions)
        }
    }
    
    func receivedSessions(sessions: [Session]) {
        
        // Sort sessionObjects by date and time
        sessionObjects = sessions.sorted({$0.startDateTime!.timeIntervalSinceNow < $1.startDateTime!.timeIntervalSinceNow})
        
        // Determine the unique dates of the sessions and put it in a dateSet list
        var dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "EEEE, MMMM dd"
        
        for session in sessionObjects {
            dateSet.insert(dateFormatter.stringFromDate(session.startDateTime!))
        }
        
        // TODO: Nevermind - need a dictionary containing two lists with a dateFormat key
        
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
            self.tableView.reloadData()
        })
        
        NSLog("receivedSessions")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Segues
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ShowSessionDetail" {
            if let indexPath = self.tableView.indexPathForSelectedRow() {
                let object = sessionObjects[indexPath.row] as Session
                NSLog("showing session detail")
                (segue.destinationViewController as! SessionDetailViewController).detailItem = object
            }
        }
    }
    
    // MARK: - Table View
    
    // TODO: Format the section headers
    // TODO: Format the session cells
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return dateSet.count
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sessionObjects.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("SessionCell", forIndexPath: indexPath) as! UITableViewCell
        
        // If date is 5/28, use section 0
        // Else use section 1
        
        let object = sessionObjects[indexPath.row] as Session
        cell.textLabel!.text = object.startDateTime?.description
        return cell
    }

}
