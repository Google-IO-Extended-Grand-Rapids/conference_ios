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
    var location: Location?
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
        startDate       <- (map["startDate"], CustomDateFormatTransform(formatString: "yyyy-MM-dd'T'HH:mm:ss"))
        endDate         <- (map["endDate"], CustomDateFormatTransform(formatString: "yyyy-MM-dd'T'HH:mm:ss"))
        location        <- map["locationView"]
        createDttm      <- (map["createDttm"], CustomDateFormatTransform(formatString: "yyyy-MM-dd'T'HH:mm:ss"))
        lastUpdateDttm  <- (map["lastUpdateDttm"], CustomDateFormatTransform(formatString: "yyyy-MM-dd'T'HH:mm:ss"))
    }
    
}