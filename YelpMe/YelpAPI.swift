 //
 //  YelpAPI.swift
 //  YelpMe
 //
 //  Created by Vinu Charanya on 2/10/16.
 //  Copyright © 2016 vnu. All rights reserved.
 //
 
 import UIKit
 
 class YelpAPI{
    
    static let sharedInstance = YelpAPI()
    
    private let httpClient: HTTPClient
    private let isOnline: Bool
    
    init(){
        httpClient = HTTPClient()
        isOnline = false
    }
    
    func searchWithTerm(term: String, completion: ([Business]!, NSError!) -> Void) {
        httpClient.searchWithTerm(term, completion: completion)
    }
    
    func searchWithTerm(term: String, sort: String?, categories: [String]?, deals: Bool?, distance: String?, completion: ([Business]!, NSError!) -> Void) -> Void {
        httpClient.searchWithTerm(term, sort: sort, categories: categories, deals: deals, distance: distance, completion: completion)
    }
 }
