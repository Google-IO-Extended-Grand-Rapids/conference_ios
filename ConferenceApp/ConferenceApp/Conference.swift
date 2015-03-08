//
//  Conference.swift
//  ConferenceApp
//
//  Created by Dan McCracken on 3/7/15.
//  Copyright (c) 2015 GR OpenSource. All rights reserved.
//

import Foundation
import ObjectMapper

class Conference : Mappable {
    
    var id: Int?
    var name: String?
    var shortDesc: String?
    var fullDesc: String?
    var startDate: NSDate?
    var endDate: NSDate?
    //var location: Location?
    var createDttm: NSDate?
    var lastUpdateDttm: NSDate?
    
    required init?(_ map: Map) {
        mapping(map)
    }
    
    // Mappable
    func mapping(map: Map) {
        id              <- map["id"]
        name            <- map["name"]
        shortDesc       <- map["shortDesc"]
        fullDesc        <- map["fullDesc"]
        startDate       <- (map["startDate"], CustomDateTransform())
        endDate         <- (map["endDate"], CustomDateTransform())
        createDttm      <- (map["createDttm"], CustomDateTransform())
        lastUpdateDttm  <- (map["lastUpdateDttm"], CustomDateTransform())
    }
    
}