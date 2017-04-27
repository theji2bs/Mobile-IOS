//
//  EventCollectionViewCell.swift
//  OwIApp
//
//  Created by MALIDI ELHADAD on 27/04/2017.
//  Copyright © 2017 MALIDI ELHADAD. All rights reserved.
//

import UIKit
import Haneke

class EventCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "event_cell_identifier"
    
    @IBOutlet weak var eventLabel: UILabel!
    @IBOutlet weak var eventImageView: UIImageView!
    
    var event: Event! {
        didSet {
            eventLabel.text = event.name
            if let imageUrl = event.imageUrl, let url = URL(string: imageUrl) {
                 eventImageView.hnk_setImageFromURL(url)
            }
            
            
        }
    }
    
    
}
