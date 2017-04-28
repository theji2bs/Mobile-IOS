//
//  ViewController.swift
//  OwIApp
//
//  Created by MALIDI ELHADAD on 27/04/2017.
//  Copyright © 2017 MALIDI ELHADAD. All rights reserved.
//

import UIKit
import LocalAuthentication



enum SegueIdentifier: String {
    case detailEvent = "segue_detail_event"
}

class ViewController: UIViewController {
    
    
    lazy var events = [Event]()

    @IBOutlet weak var mainCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        
        // Touchid 
        
         let context = LAContext()
        
        context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "Je veux ton doigt"){
            (success, error) in
            print("sucess: \(success)")
            
            
            if success {
                //
            }
        }
        
        
        EventManager.retrieveAllEvent(success: { (events) in
            
            self.events.removeAll()
            self.events+=events
            
            self.mainCollectionView.reloadData()
            
        }) { (error) in
            
            
            
        }
    }

    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard let identifier = segue.identifier, let segueIdentifier = SegueIdentifier(rawValue: identifier) else {
            fatalError("Segue identifier not recongnized")
            
        }
        switch segueIdentifier {
        case .detailEvent:
            let eventDetailViewController = segue.destination as! EventDetailViewController
            
            if let indexPaths = mainCollectionView.indexPathsForSelectedItems, let indexPath = indexPaths.first{
                
                let eventId = events[indexPath.row].id
                
                eventDetailViewController.eventId = eventId
                
            }
            break
        }
    }
    
    
    

}

extension ViewController: UICollectionViewDataSource {
    
    

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return events.count
    }
    

    
    
    

    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EventCollectionViewCell.identifier, for: indexPath) as! EventCollectionViewCell
        
       
         cell.event = events[indexPath.row]
        
        return cell
    
    }
}


