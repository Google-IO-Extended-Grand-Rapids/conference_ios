//
//  Session.swift
//  ConferenceApp
//
//  Created by Dan McCracken on 4/2/15.
//  Copyright (c) 2015 GR OpenSource. All rights reserved.
//

import Foundation
import ObjectMapper

class Session : Mappable {
    
    var id: Int?
    var name: String?
    var shortDesc: String?
    var fullDesc: String?
    var startDateTime: NSDate?
    var durationMinutes: Int?
    var roomId: Int?
    var conferenceId: Int?
    var createDttm: NSDate?
    var lastUpdateDttm: NSDate?
    
    // TODO :- presenterIds or list of Presenter objects please!!
    // TODO :- roomId replaced with Room object please!!
    
    required init?(_ map: Map) {
        mapping(map)
    }
    
    // Mappable
    func mapping(map: Map) {
        id              <- map["id"]
        name            <- map["name"]
        shortDesc       <- map["shortDesc"]
        fullDesc        <- map["fullDesc"]
        startDateTime   <- (map["startDttm"], DateTransform())
        durationMinutes <- map["durationMinutes"]
        roomId          <- map["roomId"]
        conferenceId    <- map["conferenceId"]
        createDttm      <- (map["createDttm"], DateTransform())
        lastUpdateDttm  <- (map["lastUpdateDttm"], DateTransform())
    }
    
}
