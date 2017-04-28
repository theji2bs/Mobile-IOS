//
//  EventManager.swift
//  OwIApp
//
//  Created by MALIDI ELHADAD on 27/04/2017.
//  Copyright © 2017 MALIDI ELHADAD. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON


class EventManager {
    
    
    
    
    typealias ResultsEvents = (_ events: [Event])-> Void
    
    // equivalent de func method
    typealias FailureEvents = (_ error: Error) -> Void
    
    
    typealias ResultEvent = (_ event: Event) -> Void
    typealias FailureEvent = FailureEvents
    
    
    
    
    
    
    
    
    
    
    
    
    static func retrieveAllEvent(success: @escaping ResultsEvents, failure: @escaping FailureEvents) {
        
        let url = UrlBuilder.allEvents
        
        Alamofire.request(url).responseData { (response) in
            
            switch response.result{
            case .success(let data):
                
                
                do {
                    var events = [Event]() // equivalent de <Event>()
                    
                    if let jsonRoot = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] {
                        
                        let eventDao = EventDao.sharedInstance
                        
                        if let jsonEvents = jsonRoot["data"] as? [[String: Any]] {
                            for jsonEvent in jsonEvents {
                                let eventId = jsonEvent["id"] as? String ?? ""
                                var event = eventDao.findEvent(eventId: eventId)
                                
                                if event == nil{
                                    event = eventDao.createEvent()
                                }
                                event?.fill(jsonEvent)
                                
                                
                                if let currentEvent = event {
                                    events.append(currentEvent)
                                }
                                
                            }
                            
                            success(events)
                            // sauvegarde des donnees
                            eventDao.saveContext()
                            
                        }
                        
                    }
                    
                    
                } catch let error {
                    failure(error)
                    
                }
                
                break
                
            case .failure(let error):
                failure(error)
                
                
                break
            }
        }
        
        
        
        
    }
    
    
    
    
    static func retrieveEventDetail(eventId: String, success: @escaping ResultEvent, failure: @escaping FailureEvent){
        
        let eventDao = EventDao.sharedInstance

        guard let eventFromDatabase = eventDao.findEvent(eventId: eventId) else {
            // code réseau
            let url = UrlBuilder.event(eventId: eventId)
            Alamofire.request(url).responseData { (response) in
                switch response.result {
                    
                case .success(let value):
                    
                    let jsonRoot = JSON(value)
                    
                    let jsonEvent = jsonRoot["data"]
                    
                    
                    var event = eventDao.findEvent(eventId: jsonEvent["id"].stringValue)
                    
                    if event == nil {
                        event = eventDao.createEvent()
                    }
                    
                    event?.fill(jsonEvent.dictionaryValue)
                    
                    if let currentEvent = event {
                        success(currentEvent)
                        
                        // sauvegarde des donnees
                        eventDao.saveContext()
                        
                    }
                    
                    break
                    
                    
                case .failure(let error):
                    
                    print("error: \(error)")
                    
                    break
                }
                
            }
            
            return
        }
        
        success(eventFromDatabase)
        // code réseaux ici precedemment
    }
    
        
        
}
    

