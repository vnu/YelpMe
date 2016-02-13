//
//  YelpResult.swift
//  YelpMe
//
//  Created by Vinu Charanya on 2/12/16.
//  Copyright © 2016 vnu. All rights reserved.
//

import UIKit

class Business: NSObject{
    
    let rating: Double?
    let reviewCount: Int?
    let name: String?
    let categories:String?
    let phone: String?
    let imageUrl: String?
    let businessId: String?
    let isClosed: Bool?
    let location: BusinessLocation?
    
    init(dictionary: NSDictionary){
        self.rating = dictionary["rating"] as? Double
        self.reviewCount = dictionary["review_count"] as? Int
        self.name = dictionary["name"] as? String
        self.phone = dictionary["phone"] as? String
        self.imageUrl = dictionary["image_url"] as? String
        self.businessId = dictionary["id"] as? String
        self.isClosed = dictionary["is_closed"] as? Bool
        self.location = BusinessLocation(dictionary: dictionary["location"] as! NSDictionary)
        
        var categories = ""
        if let categoriesArray = dictionary["categories"] as? [[String]] {
            if categoriesArray.count > 0{
                var categoryNames = [String]()
                for category in categoriesArray{
                    categoryNames.append(category[0])
                }
                categories = categoryNames.joinWithSeparator(", ")
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
