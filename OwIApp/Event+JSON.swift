//
//  Event+JSON.swift
//  OwIApp
//
//  Created by MALIDI ELHADAD on 27/04/2017.
//  Copyright © 2017 MALIDI ELHADAD. All rights reserved.
//

import Foundation
import SwiftyJSON

extension Event {
    
    func fill(_ json: [String: Any]) {
        
        let updatedAt = json["updatedAt"] as? String ?? ""
        let createdAt = json["createdAt"] as? String ?? ""
        let name = json["name"] as? String ?? ""
        let id = json["id"] as? String ?? ""
        let imageUrl = json["imageUrl"] as? String ?? ""
        let description = json["description"] as? String ?? ""
        
        self.name = name
        self.id = id
        self.imageUrl = imageUrl
        self.descriptionText = description
        
        if let updatedAtDate = DateUtil.sharedInstance
            .dateFromString(dateString: updatedAt){
            self.updatedAt = updatedAtDate as NSDate?
            
        }
        
        
        if let createdAtDate = DateUtil.sharedInstance
            .dateFromString(dateString: createdAt){
            self.updatedAt = createdAtDate as NSDate?
            
        }
        
        
        
    }
    
    func fill(_ json: JSON) {
        
        let updatedAt = json["updatedAt"].stringValue
        let createdAt = json["createdAt"].stringValue
        let name = json["name"].stringValue
        let id = json["id"].stringValue
        let imageUrl = json["imageUrl"].stringValue
        let information = json["information"].stringValue
        let description = json["description"].stringValue
        
        
        self.name = name
        self.id = id
        self.imageUrl = imageUrl
        self.descriptionText = description
        self.information = information
        
        if let updatedAtDate = DateUtil.sharedInstance
            .dateFromString(dateString: updatedAt){
            self.updatedAt = updatedAtDate as NSDate?
            
        }
        
        
        if let createdAtDate = DateUtil.sharedInstance
            .dateFromString(dateString: createdAt){
            self.updatedAt = createdAtDate as NSDate?
            
        }
        
        
        
    }
}
