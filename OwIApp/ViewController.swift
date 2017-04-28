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
    
    @IBOutlet weak var LoadingView: UIView!
    
    @IBOutlet weak var LoadingImageView: UIImageView!
    
    
    
    
    lazy var events = [Event]()

    @IBOutlet weak var mainCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        showLoadingView()
        
        
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
            self.hideLoadingView()
            
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
    
    
    func showLoadingView(){
        LoadingView.isHidden = false
        
        let scaleAnimation = CABasicAnimation(keyPath: "transform.scale")
        scaleAnimation.fromValue = 1.0
        scaleAnimation.toValue = 10.0
        
        
        let fadeOutAnimation = CABasicAnimation(keyPath: "opacity")
            fadeOutAnimation.fromValue = 1.0
            fadeOutAnimation.toValue = 0.0
        
        let groupAnimation = CAAnimationGroup()
        groupAnimation.animations = [scaleAnimation, fadeOutAnimation]
        groupAnimation.duration = 1.0
        groupAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        groupAnimation.fillMode = kCAFillModeForwards
        groupAnimation.isRemovedOnCompletion = false
        
        LoadingImageView.layer.add(groupAnimation, forKey: "scale")
        
    }
    
    func hideLoadingView(){
        LoadingView.isHidden = true
        
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


