//
//  Event.swift
//  OwIApp
//
//  Created by MALIDI ELHADAD on 27/04/2017.
//  Copyright © 2017 MALIDI ELHADAD. All rights reserved.
//

import Foundation

class EventTemp {
    
    // structure
    struct LocationTemp {
        var longitude: Double
        var latitude: Double
    }
    
    var id: String!
    var description: String!
    var imageUrl: String!
    var information: String!
    var name: String!
    var createdAt : Date!
    var updatedAt : Date!
    var Location: LocationTemp!
    
    
    
}

extension EventTemp {
    
    convenience init(json: [String: Any]){
        
        self.init()
        
    
        let updatedAt = json["updatedAt"] as? String ?? ""
        let createdAt = json["createdAt"] as? String ?? ""
        let name = json["name"] as? String ?? ""
        let id = json["id"] as? String ?? ""
        let imageUrl = json["imageUrl"] as? String ?? ""
        
        self.name = name
        self.id = id
        self.imageUrl = imageUrl
        
            if let updatedAtDate = DateUtil.sharedInstance
                .dateFromString(dateString: updatedAt){
                    self.updatedAt = updatedAtDate
                    
                    }
        
        
        if let createdAtDate = DateUtil.sharedInstance
            .dateFromString(dateString: createdAt){
            self.updatedAt = createdAtDate
            
        }
        
        

}
}
