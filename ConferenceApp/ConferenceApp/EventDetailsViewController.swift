//
//  EventDetailsViewController.swift
//  ConferenceApp
//
//  Created by Dan McCracken on 3/7/15.
//  Copyright (c) 2015 GR OpenSource. All rights reserved.
//

import UIKit

class EventDetailsViewController: UITableViewController {
    
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
        self.configureView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Segues
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ShowSchedule" {
            NSLog("showing schedule")
                (segue.destinationViewController as ScheduleViewController).detailItem = detailItem
            
        }
    }
    
    // MARK: - Table View
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("EventDetailCell", forIndexPath: indexPath) as UITableViewCell
        
        let object = detailItem as Conference?
        cell.textLabel!.text = object?.name
        return cell
    }
    
}
