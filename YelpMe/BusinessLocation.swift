//
//  BusinessLocation.swift
//  YelpMe
//
//  Created by Vinu Charanya on 2/12/16.
//  Copyright © 2016 vnu. All rights reserved.
//

import UIKit

//"location": {
//        "cross_streets": "Jones St & Leavenworth St",
//        "city": "San Francisco",
//        "display_address": [
//        "484 Ellis St",
//        "Tenderloin",
//        "San Francisco, CA 94102"
//        ],
//        "geo_accuracy": 9.5,
//        "neighborhoods": [
//        "Tenderloin"
//        ],
//        "postal_code": "94102",
//        "country_code": "US",
//        "address": [
//        "484 Ellis St"
//        ],
//        "coordinate": {
//            "latitude": 37.7847191,
//            "longitude": -122.414172
//        },
//        "state_code": "CA"
//    }

class BusinessLocation {
    let crossStreets: String?
    let city: String?
    let displayAddress: String?
    let geoAccuracy: Double?
    let neighborhoods: String?
    let postalCode: String?
    let countryCode: String?
    let address: String?
    let latitude: Double?
    let longitude: Double?
    let stateCode: String?
    
    init(dictionary: NSDictionary){
        self.crossStreets = dictionary["cross_street"] as? String
        self.city = dictionary["city"] as? String
        self.geoAccuracy = dictionary["geo_accuracy"] as? Double
        self.postalCode = dictionary["postal_code"] as? String
        self.countryCode = dictionary["country_code"] as? String
        self.stateCode = dictionary["state_code"] as? String
        
        var displayAddress = ""
        if let displayAddressArray = dictionary["display_address"] as? Array<String>{
            if displayAddressArray.count > 0{
                displayAddress = displayAddressArray.joinWithSeparator(", ")
            }
        }
        
        self.displayAddress = displayAddress
        
        
        var address = ""
        
        if let addressArray = dictionary["address"] as? Array<String>{
            if addressArray.count > 0 {
                address = addressArray.joinWithSeparator(", ")
            }
        }
        self.address = address
        
        var neighborhoods = ""
        
        if let neighborhoodsArray = dictionary["neighborhoods"] as? Array<String>{
            neighborhoods = neighborhoodsArray.joinWithSeparator(", ")
        }
        
        self.neighborhoods = neighborhoods
        
        var lat = Double(0)
        var lng = Double(0)
        if let coordinates = dictionary["coordinate"] as? NSDictionary{
            lat = coordinates["latitude"] as! Double
            lng = coordinates["longitude"] as! Double
        }
        
        self.latitude = lat
        self.longitude = lng
    }
    
}