//
//  UrlBuilder.swift
//  OwIApp
//
//  Created by MALIDI ELHADAD on 27/04/2017.
//  Copyright © 2017 MALIDI ELHADAD. All rights reserved.
//

import Foundation


class UrlBuilder {
    
    private static let baseUrl = "http://163.172.29.197:8000"
    
    static let allEvents: String  = {
        
        return baseUrl+"/events"
}()
    
    static func event(eventId: String) -> String {
        return allEvents+"/\(eventId)"
    }
}

