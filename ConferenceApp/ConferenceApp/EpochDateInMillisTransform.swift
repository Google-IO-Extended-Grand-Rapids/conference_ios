//
//  EpochDateInMillisTransform.swift
//  ConferenceApp
//
//  Created by Dan McCracken on 5/16/15.
//  Copyright (c) 2015 GR OpenSource. All rights reserved.
//

import Foundation
import ObjectMapper

public class EpochDateInMillisTransform: DateTransform {
    override public func transformFromJSON(value: AnyObject?) -> NSDate? {
        if let timeInt = value as? Double {
            return NSDate(timeIntervalSince1970: NSTimeInterval(timeInt/1000))
        }
        return nil
    }
}