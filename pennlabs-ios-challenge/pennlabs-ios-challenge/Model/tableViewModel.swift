//
//  tableViewModel.swift
//  pennlabs-ios-challenge
//
//  Created by Daniel Salib on 9/22/18.
//  Copyright © 2018 dsalib. All rights reserved.
//

import Foundation

struct tableViewModel {
    var diningHalls = [DiningHall(name: "1920 Commons", image: #imageLiteral(resourceName: "commons")),
                       DiningHall(name: "McClelland", image: #imageLiteral(resourceName: "mcclelland")),
                       DiningHall(name: "NCH Dining", image: #imageLiteral(resourceName: "nch")),
                       DiningHall(name: "Hill House", image: #imageLiteral(resourceName: "hill")),
                       DiningHall(name: "English House", image: #imageLiteral(resourceName: "kceh")),
                       DiningHall(name: "Falk Kosher", image: #imageLiteral(resourceName: "hillel"))]
    
    //excluded pret and mba cafe as they do not have images
    var retailDining = [DiningHall(name: "Tortas Frontera", image: #imageLiteral(resourceName: "tortas")),
                        DiningHall(name: "Gourmet Grocer", image: #imageLiteral(resourceName: "gourmetgrocer")),
                        DiningHall(name: "Houston Market", image: #imageLiteral(resourceName: "houston")),
                        DiningHall(name: "Joe's Café", image: #imageLiteral(resourceName: "joes")),
                        DiningHall(name: "Mark's Café", image: #imageLiteral(resourceName: "marks")),
                        DiningHall(name: "Beefsteak", image: #imageLiteral(resourceName: "beefsteak")),
                        DiningHall(name: "Starbucks", image: #imageLiteral(resourceName: "starbucks"))]
}
