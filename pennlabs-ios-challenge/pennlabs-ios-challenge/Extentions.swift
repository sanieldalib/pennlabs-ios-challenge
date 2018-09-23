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

/* secondsFromBeginningOfTheDay from
 https://stackoverflow.com/questions/41646542/how-do-you-compare-just-the-time-of-a-date-in-swift?rq=1 */
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
}
