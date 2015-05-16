//
//  SessionDetailViewController.swift
//  ConferenceApp
//
//  Created by Dan McCracken on 4/2/15.
//  Copyright (c) 2015 GR OpenSource. All rights reserved.
//

import UIKit

class SessionDetailViewController: UITableViewController {
    
    var conferencesDao: ConferencesDao!
    
    var detailItem: Session? {
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
        
        /*
        *   So, depending on what changes we make to the API, we have to do calls here.
        *
        *   - Possibly for Room? which there is no API for right now.
        *   + Possibly for Presenter? where there IS an API for, which is nice.
        */
        
        //conferencesDao.getAllConferences(receivedConferences)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table View
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("SessionDetailCell", forIndexPath: indexPath) as! UITableViewCell
        
        let object = detailItem as Session?
        cell.textLabel!.text = object?.name
        return cell
    }
    
}
