//
//  diningHall.swift
//  pennlabs-ios-challenge
//
//  Created by Daniel Salib on 9/22/18.
//  Copyright © 2018 dsalib. All rights reserved.
//

import Foundation
import UIKit

struct DiningVenue {
    var name : String!
    var image : UIImage?
    var status : DiningStatus = .CLOSED
    var hours = [(Date, Date)]()
    var hourString = ""
    var type : VenueType!
    var url : URL?
    
    enum DiningStatus : String {
        case OPEN = "OPEN"
        case CLOSED = "CLOSED"
    }
    
    //retail spots have times for multiple sections of the retailer - adjustHours() finds max and min and turns into one range
    mutating func adjustHours() {
        if self.type == .retail && self.hours.count > 1{
            var min = hours[0].0
            var max = hours[0].0
            
            for i in 0...hours.count - 2{
                if hours[i].0 < hours[i + 1].0{
                    min = hours[i].0
                } else {
                    min = hours[i + 1].0
                }
                
                if hours[i].1 < hours[i + 1].1{
                    max = hours[i].1
                } else {
                    max = hours[i + 1].1
                }
            }
            self.hours = [(min, max)]
            self.hourString = "\(min.hourMinuteString(letters: true)) - \(max.hourMinuteString(letters: true))"
        } else if self.hours.count == 1 {
           self.hourString = "\(self.hours[0].0.hourMinuteString(letters: true)) - \(self.hours[0].1.hourMinuteString(letters: true))"
        }
    }
    
    init (name: String, image: UIImage, venueData : Venue) {
        self.name = name
        self.image = image
        self.type = venueData.venueType
        self.url = URL(string: venueData.facilityURL)

        
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "YYYY-MM-dd"
        dateFormat.timeZone = TimeZone(abbreviation: "EST")
        let today = dateFormat.string(from: Date())
        
        let timeFormat = DateFormatter()
        timeFormat.dateStyle = .none
        timeFormat.timeStyle = .medium
        timeFormat.dateFormat = "HH:mm:ss"
        timeFormat.timeZone = TimeZone(abbreviation: "EST")
        
        for date in venueData.dateHours {
            if date.date == today {
                var i = 0
                for meal in date.meal {
                    let open = timeFormat.date(from: meal.mealOpen)!
                    let close = timeFormat.date(from: meal.close)!
                    hours.append((open, close))
                    
                    if (open.secondsFromBeginningOfTheDay() <= Date().secondsFromBeginningOfTheDay() &&
                        close.secondsFromBeginningOfTheDay() > Date().secondsFromBeginningOfTheDay()){
                        status = DiningStatus.OPEN
                    }
                    
                    if (i < date.meal.count - 1){
                        hourString = "\(hourString)\(open.hourMinuteString(letters: false)) - \(close.hourMinuteString(letters: false)) | "
                    } else {
                        hourString = "\(hourString)\(open.hourMinuteString(letters: false)) - \(close.hourMinuteString(letters: false))"
                    }
                    
                    i += 1
                    
                }
                self.adjustHours()
            }
        }
    }
    
    init(name: String, image: UIImage, type: VenueType) {
        self.name = name
        self.image = image
        self.type = type
        self.hours = []
        self.hourString = ""
        self.status = .CLOSED
    }
    
}


// shoutout https://app.quicktype.io/ for making this super easy
// Codeable objects for JSONDecoder() :)
struct Welcome: Codable {
    let document: Document
}

struct Document: Codable {
    let venue: [Venue]
}

struct Venue: Codable {
    let dateHours: [DateHour]
    let facilityURL: String
    let name: String
    let id: Int
    let venueType: VenueType
}

struct DateHour: Codable {
    let date: String
    let meal: [Meal]
}

struct Meal: Codable {
    let close, mealOpen, type: String
    
    enum CodingKeys: String, CodingKey {
        case close
        case mealOpen = "open"
        case type
    }
}

enum VenueType: String, Codable {
    case residential = "residential"
    case retail = "retail"
}
