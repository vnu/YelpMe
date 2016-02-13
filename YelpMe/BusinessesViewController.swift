//
//  BusinessesViewController.swift
//  Yelp
//
//  Created by Timothy Lee on 4/23/15.
//  Copyright (c) 2015 Timothy Lee. All rights reserved.
//

import UIKit

class BusinessesViewController: UIViewController {

    var businesses: [Business]!
    
    let businessViewCellId = "com.vnu.BusinessViewCell"
    
    @IBOutlet var searchTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

       loadBusinesses()

/* Example of Yelp search with more search options specified
        Business.searchWithTerm("Restaurants", sort: .Distance, categories: ["asianfusion", "burgers"], deals: true) { (businesses: [Business]!, error: NSError!) -> Void in
            self.businesses = businesses
            
            for business in businesses {
                print(business.name!)
                print(business.address!)
            }
        }
*/
    }
    func loadBusinesses(){
        YelpAPI.sharedInstance.searchWithTerm("Indian", completion: { (businesses: [Business]!, error: NSError!) -> Void in
            self.businesses = businesses
            for business in businesses {
                print(business.categories!)
            }
            self.searchTableView.reloadData()
        })

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension BusinessesViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.businesses != nil ? self.businesses.count : 0
        //        if let businesses = self.businesses{
        //            return businesses.count
        //        }else{
        //           return 0
        //        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(businessViewCellId) as! BusinessTableViewCell
        let business = businesses[indexPath.row]
        cell.selectionStyle = .None
        cell.businessNameLabel.text = business.name!
        cell.reviewCountLabel.text = "\(business.reviewCount!)"
        cell.categoriesLabel.text = business.categories!
        cell.addressLabel.text = business.location?.address
        print("stars-\(business.rating!)")
        cell.ratingsImageView.image = UIImage(named: "stars-\(business.rating!)")
        if let businessImage = business.imageUrl{
            cell.businessImageView.setImageWithURL(NSURL(string: businessImage)!)
        }
        return cell
    }
}
