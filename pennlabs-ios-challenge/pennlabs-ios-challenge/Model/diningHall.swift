//
//  diningHall.swift
//  pennlabs-ios-challenge
//
//  Created by Daniel Salib on 9/22/18.
//  Copyright © 2018 dsalib. All rights reserved.
//

import Foundation
import UIKit

struct DiningHall {
    var name : String!
    var image : UIImage!
    var status : DiningStatus!
    var hours: String?
    
    enum DiningStatus {
        case OPEN
        case CLOSED
    }
    
    init(name: String, image: UIImage) {
        self.name = name
        self.image = image 
    }
}
