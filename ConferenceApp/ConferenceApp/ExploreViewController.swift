//
//  ExploreViewController.swift
//  ConferenceApp
//
//  Created by Dan McCracken on 3/7/15.
//  Copyright (c) 2015 GR OpenSource. All rights reserved.
//

import UIKit

class ExploreViewController: UITableViewController {
    
    var objects = NSMutableArray()
    var conferencesDao: ConferencesDao!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        conferencesDao = appDelegate.conferencesDao!
        
        conferencesDao.getAllConferences(receivedConferences)
    }
    
    func receivedConferences(conferences: NSArray) {
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
            objects.insertObject(sender, atIndex: 0)
        } else {
            objects.insertObject(NSDate().description, atIndex: 0)
        }
        
        let indexPath = NSIndexPath(forRow: 0, inSection: 0)
        self.tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
    }
    
    // MARK: - Segues
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ShowDetail" {
            if let indexPath = self.tableView.indexPathForSelectedRow() {
                let object = objects[indexPath.row] as Conference
                (segue.destinationViewController as EventDetailsViewController).detailItem = object
            }
        }
    }
    
    // MARK: - Table View
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objects.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as EventCell
        
        let object = objects[indexPath.row] as Conference
        
        let formatter = NSDateFormatter()
        formatter.dateStyle = NSDateFormatterStyle.MediumStyle
        
        cell.nameLabel.text = object.name
        cell.locationLabel.text = object.location?.name
        cell.durationLabel.text = String(format: "%@ to %@",formatter.stringFromDate(object.startDate!),formatter.stringFromDate(object.endDate!))
        if object.id! % 2 == 0 {
            cell.backgroundImageView.image = UIImage(named: "GRDark.jpg")
        } else {
            cell.backgroundImageView.image = UIImage(named: "GRLight.jpg")
        }
        
        return cell
    }
    
}