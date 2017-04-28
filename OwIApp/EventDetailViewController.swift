//
//  EventDetailViewController.swift
//  OwIApp
//
//  Created by MALIDI ELHADAD on 28/04/2017.
//  Copyright © 2017 MALIDI ELHADAD. All rights reserved.
//

import UIKit
import Haneke
import CoreLocation

class EventDetailViewController: UIViewController {
    
    @IBOutlet weak var eventImageView: UIImageView!
    
    @IBOutlet weak var eventTextView: UITextView!
    
    @IBOutlet weak var distanceLabel: UILabel!
    
    
    
    private var LocationManager: CLLocationManager!
    
    
    var event: Event?
    
    var eventId: String!

    override func viewDidLoad() {
        super.viewDidLoad()

        
        
            LocationManager = CLLocationManager()
            LocationManager.delegate = self
        
            LocationManager.requestWhenInUseAuthorization()
            LocationManager.requestLocation()
        
        // Do any additional setup after loading the view.
        
        eventTextView.text = ""
        
        EventManager.retrieveEventDetail(eventId: eventId, success: {
            
            (event) in
            self.event = event
            // refresh UI
            
            self.eventTextView.text = event.descriptionText
            
            if let imageUrl = event.imageUrl,
                let url = URL(string: imageUrl) {
                self.eventImageView.hnk_setImageFromURL(url)
            }
            
        }) { (error) in
            print("error: \(error)")
            
        }
    
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension EventDetailViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first,
            let currentEventLocation = event?.location{
            
            let eventLocation = CLLocation(latitude: currentEventLocation.latitude, longitude: currentEventLocation.longitude)
            
            let distance = location.distance(from: eventLocation)
            
        }
    }
}
