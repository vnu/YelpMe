//
//  ViewController.swift
//  YelpMe
//
//  Created by Vinu Charanya on 2/11/16.
//  Copyright © 2016 vnu. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {

    let resultCellID = "com.vnu.yelpResultCell"
    
    @IBOutlet var searchResultsTable: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}

extension SearchViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(resultCellID) as! YelpResultTableViewCell
        return cell
    }
}

