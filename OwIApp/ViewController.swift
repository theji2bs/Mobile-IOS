//
//  ViewController.swift
//  OwIApp
//
//  Created by MALIDI ELHADAD on 27/04/2017.
//  Copyright © 2017 MALIDI ELHADAD. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    lazy var events = [Event]()

    @IBOutlet weak var mainCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        EventManager.retrieveAllEvent(success: { (events) in
            
            self.events.removeAll()
            self.events+=events
            
            self.mainCollectionView.reloadData()
            
        }) { (error) in
            
            
            
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


