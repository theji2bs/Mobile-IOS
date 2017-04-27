//
//  DateUtil.swift
//  OwIApp
//
//  Created by MALIDI ELHADAD on 27/04/2017.
//  Copyright © 2017 MALIDI ELHADAD. All rights reserved.
//

import Foundation

class DateUtil {
    
    fileprivate lazy var dateFormatter = DateFormatter()
   // singleton
    static let sharedInstance: DateUtil = {
        return DateUtil()
    }()
    
    init() {
        dateFormatter.dateFormat = "yyyy-MM-dd-'T'HH:mm:ssZ"
    }
    
    func dateFromString(dateString: String) -> Date? {
        return dateFormatter.date(from: dateString)
    }
}
