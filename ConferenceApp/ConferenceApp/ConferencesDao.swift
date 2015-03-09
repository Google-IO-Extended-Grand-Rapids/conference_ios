//
//  ConferencesDao.swift
//  ConferenceApp
//
//  Created by Dan McCracken on 3/7/15.
//  Copyright (c) 2015 GR OpenSource. All rights reserved.
//

import Foundation
import ObjectMapper

class ConferencesDao {
    func makeRequestToAPI(url: String, onCompletion:(NSArray) -> ()) {
        let realUrl = NSURL(string: url)
        let request = NSURLRequest(URL: realUrl!)
        
        let task : NSURLSessionDataTask = NSURLSession.sharedSession().dataTaskWithRequest(request) {
            (data, response, error) in
            
            let json = NSJSONSerialization.JSONObjectWithData(data, options: .MutableContainers, error: nil) as NSArray
            
            dispatch_async(dispatch_get_main_queue(), {
                onCompletion(json)
            })
            
        }
        task.resume()
    }
    
    func getAllConferences(conferenceHandler: (NSArray) -> ()) {
        makeRequestToAPI("http://104.236.204.59:8080/api/conference") {
            json in
            
            var arrayOfConferenceObjects: [Conference] = []

            if let conferenceArray = json as NSArray? {
                for item in conferenceArray {
                    let conference = Mapper<Conference>().map(item)
                    arrayOfConferenceObjects.append(conference!)
                }
            }
            
            conferenceHandler(arrayOfConferenceObjects)
        }
    }
    
    func getConferenceById(conferenceId: Int, conferenceHandler: (Conference) -> ()) {
        makeRequestToAPI("http://104.236.204.59:8080/api/conference/\(conferenceId)") {
            json in
            
            let conference = Mapper<Conference>().map(json)
            
            conferenceHandler(conference!)
        }
    }
    
}