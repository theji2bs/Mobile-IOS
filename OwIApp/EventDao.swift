//
//  EventDao.swift
//  OwIApp
//
//  Created by MALIDI ELHADAD on 27/04/2017.
//  Copyright © 2017 MALIDI ELHADAD. All rights reserved.
//

import Foundation
import CoreData

class EventDao {
    
    
    
    
    
    static let sharedInstance: EventDao = {
        return EventDao()
    }()
    
    func allEvents() -> [Event] {
        
        let fetchRequest = NSFetchRequest<Event>(entityName: "Event")
    
        do {
             let results = try persistentContainer.viewContext.fetch(fetchRequest)
            
            return results
        } catch let error {
                
        
        }
        return [Event]()
    }
    
    func createEvent() -> Event {
       // let entityDescription = NSEntityDescription.entity(forEntityName: "Event", in: NSManagedObjectContext)
      //  let event = Event(entity: entityDescription, insertInto: NSManagedObjectContext)
        
        let managedObjectContext = persistentContainer.viewContext
        
        let event = Event(context: managedObjectContext)
        
        return event
    }
    
    
    
    func createLocation(latitude: Double?, longitude: Double? ) -> EventLocation {
        
        let managedObjectContext = persistentContainer.viewContext
        
        let location = EventLocation(context: managedObjectContext)
        
        if let realLatitude = latitude, let realLongitude = longitude {
            location.latitude = realLatitude
            location.longitude = realLongitude
        }
        
        return location
        
    }

    func findEvent(eventId: String) -> Event?{
        
        let fetchRequest = NSFetchRequest<Event>(entityName: "Event")
        fetchRequest.predicate = NSPredicate(format: "id=%@", eventId)
        
        do {
            let results = try persistentContainer.viewContext.fetch(fetchRequest)
            return results.first // Event?
            
        } catch let error {
            
            print("error: \(error)")
        }
        
        return .none
    }
    
    // MARK: - Core Data stack
    
    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
         */
        let container = NSPersistentContainer(name: "OwIApp")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

    
}
