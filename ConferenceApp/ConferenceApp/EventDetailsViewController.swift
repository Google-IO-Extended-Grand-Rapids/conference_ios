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
                (segue.destinationViewController as! ScheduleViewController).detailItem = detailItem
            
        }
    }
    
    // MARK: - Table View
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (section == 0) {
            return 1
        } else {
            return 3
        }
    }
    
    override func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if (indexPath.section == 0) {
            return 200
        } else {
            return UITableViewAutomaticDimension
        }

    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if (indexPath.section == 0) {
            return 200
        } else {
            return UITableViewAutomaticDimension
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("EventDetailCell", forIndexPath: indexPath) as! UITableViewCell
        
        let object = detailItem as Conference!
        
        if (indexPath.section == 0) {
            let cell = tableView.dequeueReusableCellWithIdentifier("BackgroundImageCell", forIndexPath: indexPath) as! BackgroundImageCell
            
            if object.id! % 2 == 0 {
                cell.backgroundImage.image = UIImage(named: "GRDark.jpg")
            } else {
                cell.backgroundImage.image = UIImage(named: "GRLight.jpg")
            }
        } else {
            if (indexPath.row == 0) {
                let cell = tableView.dequeueReusableCellWithIdentifier("EventDetailCell", forIndexPath: indexPath) as! EventDetailCell
                
                cell.detailLabel.text = object.fullDesc
                cell.scheduleButton.addTarget(self, action: "scheduleButtonPressed:", forControlEvents: UIControlEvents.TouchUpInside)
                cell.scheduleButton.backgroundColor = UIColor(red: 40.0/255.0, green: 154.0/255.0, blue: 214.0/255.0, alpha: 1)
                cell.scheduleButton.layer.cornerRadius = 5
                return cell
            } else if (indexPath.row == 1) {
                let cell = tableView.dequeueReusableCellWithIdentifier("SponsorsCell", forIndexPath: indexPath) as! SponsorsCell

                return cell
            } else if (indexPath.row == 2) {

            }
        }
        return cell
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if (section == 1) {
            return 70
        } else {
            return 0
        }
    }
    
    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        let object = detailItem as Conference!
        let formatter = NSDateFormatter()
        formatter.dateStyle = NSDateFormatterStyle.MediumStyle
        
        let eventLabel = UILabel(frame: CGRectMake(12, 6, 588, 30))
        eventLabel.text = object.name
        eventLabel.textColor = UIColor .whiteColor()
        eventLabel.font = UIFont .boldSystemFontOfSize(18)
        headerView .addSubview(eventLabel)
        
        let durationLabel = UILabel(frame: CGRectMake(12, 30, 588, 30))
        durationLabel.text = String(format: "%@ to %@",formatter.stringFromDate(object.startDate!),formatter.stringFromDate(object.endDate!))
        durationLabel.textColor = UIColor .whiteColor()
        durationLabel.font = UIFont .boldSystemFontOfSize(12)
        headerView .addSubview(durationLabel)
        
        headerView.backgroundColor = UIColor(red: 99.0/255.0, green: 119.0/255.0, blue: 198.0/255.0, alpha: 1)
        
        if (section == 1) {
            return headerView
        } else {
            return nil
        }
    }
    
    func scheduleButtonPressed(sender: UIButton){
        NSLog("touched button")
    }
}
