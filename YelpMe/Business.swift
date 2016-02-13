//
//  YelpResult.swift
//  YelpMe
//
//  Created by Vinu Charanya on 2/12/16.
//  Copyright © 2016 vnu. All rights reserved.
//

import UIKit

class Business: NSObject{
    
    let rating: String?
    let reviewCount: Int?
    let name: String?
    let categories:String?
    let phone: String?
    let imageUrl: String?
    let businessId: String?
    let isClosed: Bool?
    let location: BusinessLocation?
    
    init(dictionary: NSDictionary){
        self.rating = dictionary["rating"] as? String
        self.reviewCount = dictionary["review_count"] as? Int
        self.name = dictionary["name"] as? String
        self.phone = dictionary["phone"] as? String
        self.imageUrl = dictionary["imageUrl"] as? String
        self.businessId = dictionary["id"] as? String
        self.isClosed = dictionary["is_closed"] as? Bool
        self.location = BusinessLocation(dictionary: dictionary["location"] as! NSDictionary)
        
        var categories = ""
        if let categoriesArray = dictionary["categories"] as? Array<String> {
            if categoriesArray.count > 0{
                categories = categoriesArray.joinWithSeparator(", ")
            }
        }
        self.categories = categories
    }
    
    class func businesses(array array: [NSDictionary]) -> [Business] {
        var businesses = [Business]()
        for dictionary in array {
            let business = Business(dictionary: dictionary)
            businesses.append(business)
        }
        return businesses
    }
    
    
}
