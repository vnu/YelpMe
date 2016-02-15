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
    var searchBar:UISearchBar!
    
    let businessViewCellId = "com.vnu.BusinessViewCell"
    
    @IBOutlet var searchTableView: UITableView!
    
    override func viewDidLoad() {
       super.viewDidLoad()
       loadBusinesses()
       setupSearchBar()
    }
    
    func setupSearchBar(){
        searchBar = UISearchBar()
        searchBar?.sizeToFit()
        navigationItem.titleView = searchBar
        searchBar.delegate = self
    }

    func loadBusinesses(searchText: String = "Restaurants"){
        YelpAPI.sharedInstance.searchWithTerm(searchText, completion: { (businesses: [Business]!, error: NSError!) -> Void in
            self.businesses = businesses
            self.searchTableView.reloadData()
        })

    }

    func searchBusinesses(searchText: String = "Restaurants", categories: [String]? = []){
        YelpAPI.sharedInstance.searchWithTerm(searchText, sort: .Distance, categories: categories, deals: true) { (businesses: [Business]!, error: NSError!) -> Void in
            self.businesses = businesses
            self.searchTableView.reloadData()
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}

extension BusinessesViewController:FiltersViewControllerDelegate{
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let navigationController = segue.destinationViewController as! UINavigationController
        let filtersViewController = navigationController.topViewController as! FiltersViewController
        filtersViewController.delegate = self
    }
    
    func filtersViewController(filtersViewController: FiltersViewController, didUpdateFilters filters: [String : AnyObject]) {
        let categories = filters["Categories"] as? [String]
        searchBusinesses(categories: categories)
    }
    
}

extension BusinessesViewController:UISearchBarDelegate{
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        if !searchText.isEmpty{
            loadBusinesses(searchText)
        }
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
