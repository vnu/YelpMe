//
//  BusinessesViewController.swift
//  Yelp
//
//  Created by Vinu Charanya on 2/10/16.
//  Copyright © 2016 Vnu. All rights reserved.
//

import UIKit

class BusinessesViewController: UIViewController {

    var businesses: [Business]!
    
    let businessViewCellId = "com.vnu.BusinessViewCell"
    
    @IBOutlet var searchTableView: UITableView!
    
    override func viewDidLoad() {
       super.viewDidLoad()
       loadBusinesses()
    }
    func loadBusinesses(){
        YelpAPI.sharedInstance.searchWithTerm("Indian", completion: { (businesses: [Business]!, error: NSError!) -> Void in
            self.businesses = businesses
            Business.printAll(businesses)
            self.searchTableView.reloadData()
        })

    }
    
    func searchBusinesses(){
        YelpAPI.sharedInstance.searchWithTerm("Restaurants", sort: .Distance, categories: ["asianfusion", "burgers"], deals: true) { (businesses: [Business]!, error: NSError!) -> Void in
            self.businesses = businesses
            Business.printAll(businesses)
            self.searchTableView.reloadData()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}

extension BusinessesViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.businesses != nil ? self.businesses.count : 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(businessViewCellId) as! BusinessTableViewCell
        cell.business = businesses[indexPath.row]
        return cell
    }
}
