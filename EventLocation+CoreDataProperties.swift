//
//  EventLocation+CoreDataProperties.swift
//  
//
//  Created by MALIDI ELHADAD on 27/04/2017.
//
//

import Foundation
import CoreData


extension EventLocation {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<EventLocation> {
        return NSFetchRequest<EventLocation>(entityName: "EventLocation")
    }

    @NSManaged public var latitude: Double
    @NSManaged public var longitude: Double

}
