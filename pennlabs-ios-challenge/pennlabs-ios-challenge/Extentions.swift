//
//  Extentions.swift
//  pennlabs-ios-challenge
//
//  Created by Daniel Salib on 9/22/18.
//  Copyright © 2018 dsalib. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    static let openColor = UIColor(red: 1, green: 193/255, blue: 7/255, alpha: 1)
    static let statusColor = UIColor(red: 74/255, green: 74/255, blue: 74/255, alpha: 1)
}

//secondsFromBeginningOfTheDay from https://stackoverflow.com/questions/41646542/how-do-you-compare-just-the-time-of-a-date-in-swift?rq=1
extension Date {
    func secondsFromBeginningOfTheDay() -> Int {
        let calendar = Calendar.current
        // omitting fractions of seconds for simplicity
        let dateComponents = calendar.dateComponents([.hour, .minute, .second], from: self)
        
        let dateSeconds = dateComponents.hour! * 3600 + dateComponents.minute! * 60 + dateComponents.second!
        
        return dateSeconds
    }
    
    func hourMinuteString(letters : Bool) -> String {
        let calendar = Calendar.current
        
        let dateComponents = calendar.dateComponents([.hour, .minute], from: self)
        
        let letter = dateComponents.hour! >= 12 ? "p" : "a"
        
        let hour = dateComponents.hour! > 12 ? dateComponents.hour! - 12 : dateComponents.hour!
        
        if dateComponents.minute! == 0 {
            return letters ? "\(hour)\(letter)": "\(hour)"
        }
    
        return letters ? "\(hour):\(dateComponents.minute!)\(letter)": "\(hour):\(dateComponents.minute!)"
        
    }
    
    // Interval between two times of the day in seconds
    //    func timeOfDayInterval(toDate date: Date) -> TimeInterval {
    //        let date1Seconds = self.secondsFromBeginningOfTheDay()
    //        let date2Seconds = date.secondsFromBeginningOfTheDay()
    //        return date2Seconds - date1Seconds
    //    }
}

//if let date1 = date1, let date2 = date2 {
//    let diff = date1.timeOfDayInterval(toDate: date2)
//    
//    // as text
//    if diff > 0 {
//        print("Time of the day in the second date is greater")
//    } else if diff < 0 {
//        print("Time of the day in the first date is greater")
//    } else {
//        print("Times of the day in both dates are equal")
//    }
//    
//    
//    // show interval as as H M S
//    let timeIntervalFormatter = DateComponentsFormatter()
//    timeIntervalFormatter.unitsStyle = .abbreviated
//    timeIntervalFormatter.allowedUnits = [.hour, .minute, .second]
//    print("Difference between times since midnight is", timeIntervalFormatter.string(from: diff) ?? "n/a")
//    
//}


//@IBDesignable
//class DesignableView: UIView {
//}
//
//extension UIView {
//
//    @IBInspectable
//    var cornerRadius: CGFloat {
//        get {
//            return layer.cornerRadius
//        }
//        set {
//            layer.masksToBounds = true
//            layer.cornerRadius = newValue
//        }
//    }
//}
