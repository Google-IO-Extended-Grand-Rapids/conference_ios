//
//  CustomDateTransform.swift
//  ConferenceApp
//
//  Created by Dan McCracken on 3/8/15.
//  Copyright (c) 2015 GR OpenSource. All rights reserved.
//

import Foundation
import ObjectMapper

public class CustomDateTransform: TransformType {
    public typealias Object = NSDate
    public typealias JSON = String

	public init() {}

	private lazy var dateFormatter: NSDateFormatter = {
		let formatter = NSDateFormatter()
		formatter.locale = NSLocale(localeIdentifier: "en_US_POSIX")
		formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
		return formatter
	}()

	public func transformFromJSON(value: AnyObject?) -> NSDate? {
		if let dateString = value as? String {
			return dateFormatter.dateFromString(dateString)
		}
		return nil
	}

	public func transformToJSON(value: NSDate?) -> String? {
		if let date = value {
			return dateFormatter.stringFromDate(date)
		}
		return nil
	}
}