//
//  HTTPClient.swift
//  YelpMe
//
//  Created by Vinu Charanya on 2/10/16.
//  Copyright © 2016 vnu. All rights reserved.
//
let yelpConsumerKey = "3O_QAfnr7VV-oLljo6KiBQ"
let yelpConsumerSecret = "qv6Rro07E2zmfHFbYZhd64TCbfc"
let yelpToken = "SjEmNlPN7uWIE0-3aGUMIt2rCa2cZPTm"
let yelpTokenSecret = "4hpfPdbzhv0rVK6SdCOvGDSLkOg"


import AFNetworking
import BDBOAuth1Manager

import UIKit

enum YelpSortMode: Int {
    case BestMatched = 0, Distance, HighestRated
}


class HTTPClient: BDBOAuth1RequestOperationManager{
    
    var accessToken:String!
    var accessSecret:String!
    
    let yelpBaseURL = "https://api.yelp.com/v2/"
    
    init() {
        self.accessToken = yelpToken
        self.accessSecret = yelpTokenSecret
        let baseUrl = NSURL(string: self.yelpBaseURL)
        super.init(baseURL: baseUrl, consumerKey: yelpConsumerKey, consumerSecret: yelpConsumerSecret);
        
        let token = BDBOAuth1Credential(token: accessToken, secret: accessSecret, expiration: nil)
        self.requestSerializer.saveAccessToken(token)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func searchWithTerm(term: String, completion: ([Business]!, NSError!) -> Void) -> AFHTTPRequestOperation {
        return searchWithTerm(term, sort: nil, categories: nil, deals: nil, completion: completion)
    }
    
    func searchWithTerm(term: String, sort: YelpSortMode?, categories: [String]?, deals: Bool?, completion: ([Business]!, NSError!) -> Void) -> AFHTTPRequestOperation {
        // For additional parameters, see http://www.yelp.com/developers/documentation/v2/search_api
        
        // Default the location to San Francisco
        var parameters: [String : AnyObject] = ["term": term, "ll": "37.785771,-122.406165"]
        
        if sort != nil {
            parameters["sort"] = sort!.rawValue
        }
        
        if categories != nil && categories!.count > 0 {
            parameters["category_filter"] = (categories!).joinWithSeparator(",")
        }
        
        if deals != nil {
            parameters["deals_filter"] = deals!
        }
        
//        print(parameters)
        
        return self.GET("search", parameters: parameters, success: { (operation: AFHTTPRequestOperation!, response: AnyObject!) -> Void in
            let dictionaries = response["businesses"] as? [NSDictionary]
            if dictionaries != nil {
                completion(Business.businesses(array: dictionaries!), nil)
            }
            }, failure: { (operation: AFHTTPRequestOperation?, error: NSError!) -> Void in
                completion(nil, error)
        })!
    }
    
}
