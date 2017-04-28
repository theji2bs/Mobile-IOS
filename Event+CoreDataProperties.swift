//
//  Event+CoreDataProperties.swift
//  
//
//  Created by MALIDI ELHADAD on 27/04/2017.
//
//

import Foundation
import CoreData


extension Event {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Event> {
        return NSFetchRequest<Event>(entityName: "Event")
    }

    @NSManaged public var createdAt: NSDate?
    @NSManaged public var descriptionText: String?
    @NSManaged public var id: String?
    @NSManaged public var imageUrl: String?
    @NSManaged public var information: String?
    @NSManaged public var name: String?
    @NSManaged public var updatedAt: NSDate?
    @NSManaged public var location: EventLocation?

}

extension Event{
    
    var isEmpty:Bool {
        
        guard let descriptionValue = self.descriptionText, let nameValue = self.name else {
            
            return false
        }
        
        
        return descriptionValue.isEmpty && nameValue.isEmpty
    }
}

