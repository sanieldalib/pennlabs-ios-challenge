//
//  tableViewModel.swift
//  pennlabs-ios-challenge
//
//  Created by Daniel Salib on 9/22/18.
//  Copyright © 2018 dsalib. All rights reserved.
//

import Foundation
import UIKit

struct tableViewModel {
    
    let names = [593:"1920 Commons", 636: "Hill House", 637: "English House", 638 : "Falk Kosher",
                 639 : "Houston Market", 640 : "Mark's Café", 641 : "Accenture Café", 642 : "Joe's Café",
                 1442 : "NCH Dining", 747 : "McClelland", 1057 : "Gourmet Grocer", 1058 : "Tortas Frontera",
                 1163 : "Starbucks", 1731 : "NCH Retail", 1732 : "MBA Café", 1733 : "Pret a Manger"]
    
    let images = [593: #imageLiteral(resourceName: "commons"), 636: #imageLiteral(resourceName: "hill"), 637: #imageLiteral(resourceName: "kceh"), 638 : #imageLiteral(resourceName: "hillel"), 639 : #imageLiteral(resourceName: "houston"), 640 : #imageLiteral(resourceName: "marks"), 642 : #imageLiteral(resourceName: "joes"),
                 1442 : #imageLiteral(resourceName: "nch"), 747 : #imageLiteral(resourceName: "mcclelland"), 1057 : #imageLiteral(resourceName: "gourmetgrocer"), 1058 : #imageLiteral(resourceName: "tortas"), 1163 : #imageLiteral(resourceName: "starbucks")]
    
    var diningHalls = [DiningVenue]()
    var retailDining = [DiningVenue]()
    
    mutating func loadData (data: [Venue], completed: () -> ()) {
        diningHalls.removeAll()
        retailDining.removeAll()
        for venue in data {
            if (!(venue.id == 641 || venue.id == 1731 || venue.id == 1732 || venue.id == 1733)) {
                let newVenue = DiningVenue(name: names[venue.id]!, image: images[venue.id]!, venueData: venue)
                
                if (venue.venueType == .residential){
                    diningHalls.append(newVenue)
                } else {
                    retailDining.append(newVenue)
                }
            }
        }
        completed()
    }
    
    mutating func loadDefaults() {
        //in the case where JSON Decoder throws an error, defaults are loaded in
        diningHalls = [DiningVenue(name: names[593]!, image: images[593]!, type: VenueType.residential), DiningVenue(name: names[636]!, image: images[636]!, type: VenueType.residential), DiningVenue(name: names[637]!, image: images[637]!, type: VenueType.residential), DiningVenue(name: names[638]!, image: images[638]!, type: VenueType.residential), DiningVenue(name: names[1442]!, image: images[1442]!, type: VenueType.residential), DiningVenue(name: names[747]!, image: images[747]!, type: VenueType.residential)]
        
        retailDining = [DiningVenue(name: names[639]!, image: images[639]!, type: VenueType.retail), DiningVenue(name: names[640]!, image: images[640]!, type: VenueType.retail), DiningVenue(name: names[642]!, image: images[642]!, type: VenueType.retail), DiningVenue(name: names[1057]!, image: images[1057]!, type: VenueType.retail), DiningVenue(name: names[1058]!, image: images[1058]!, type: VenueType.retail), DiningVenue(name: names[1163]!, image: images[1163]!, type: VenueType.retail)]
    }

}
