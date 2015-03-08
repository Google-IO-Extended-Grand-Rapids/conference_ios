//
//  Conference.swift
//  ConferenceApp
//
//  Created by Dan McCracken on 3/7/15.
//  Copyright (c) 2015 GR OpenSource. All rights reserved.
//

import Foundation

class Conference : NSObject {
    let id: Int
    let name: String
    /*let shortDesc: String
    let fullDesc: String
    let startDate: NSDate
    let endDate: NSDate
    let location: Location
    let createDttm: NSDate
    let lastUpdateDttm: NSDate*/
    
    init(id: Int, name: String) {
        self.id = id
        self.name = name
    }
    
}