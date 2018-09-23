//
//  Networking.swift
//  pennlabs-ios-challenge
//
//  Created by Daniel Salib on 9/22/18.
//  Copyright © 2018 dsalib. All rights reserved.
//

import Foundation
import Alamofire

struct Networking {
    
    static var venues = [Venue]()
    
    //ispired by https://medium.com/@nimjea/json-parsing-in-swift-2498099b78f
    static func getData(completion: @escaping () -> ()) {
        guard let url = URL(string: "http://api.pennlabs.org/dining/venues") else {return}
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let dataResponse = data,
                error == nil else {
                    print(error?.localizedDescription ?? "Response Error")
                    return }
            do{
                let decoder = JSONDecoder()
                let model = try decoder.decode(Welcome.self, from:
                    dataResponse) //Decode JSON Response Data
                venues =  model.document.venue
                completion()
            } catch let parsingError {
                print("Error", parsingError)
            }
        }
        task.resume()
    }
}

