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
    func makeRequestToAPI(url: String, onCompletion:(NSDictionary) -> ()) {
        let realUrl = NSURL(string: url)
        let request = NSURLRequest(URL: realUrl!)
        
        let task : NSURLSessionDataTask = NSURLSession.sharedSession().dataTaskWithRequest(request) {
            (data, response, error) in
            
            let json = NSJSONSerialization.JSONObjectWithData(data, options: .MutableContainers, error: nil) as NSDictionary
            
            dispatch_async(dispatch_get_main_queue(), {
                onCompletion(json)
            })
            
        }
        task.resume()
    }
    
    func getAllConferences(conferenceHandler: (Conference) -> ()) {
        makeRequestToAPI("http://104.236.204.59:8080/api/conference") {
            json in
            
            /*
            if let value = json["value"] as? NSDictionary {
                let conferenceId = value["id"] as? Int
                let name = value["name"] as? String
                
                let conference = Conference(id: conferenceId!, name: name!)
                conferenceHandler(conference)
            }
            
            
            var conferences: [Conference] = []
            if let values = json["value"] as? NSArray {
                for value in values {
                    let remoteId = value["id"] as? Int
                    let text = value["joke"] as? String
                    
                    jokes += [Joke(id: remoteId!, text: text!)]
                }
            }
            
            jokeHandler(jokes)
            */
            
        }
    }
    
    func getConferenceById(conferenceId: Int, conferenceHandler: (Conference) -> ()) {
        makeRequestToAPI("http://104.236.204.59:8080/api/conference/\(conferenceId)") {
            json in
            
            NSLog("in the dao gettingConferenceById")
            NSLog("%@", json)
            
            let conference = Mapper<Conference>().map(json)
            conferenceHandler(conference!)
        }
    }
    
}