//
//  FiltersViewController.swift
//  YelpMe
//
//  Created by Vinu Charanya on 2/13/16.
//  Copyright © 2016 Vnu. All rights reserved.
//

import UIKit

@objc protocol FiltersViewControllerDelegate {
    optional func filtersViewController(filtersViewController: FiltersViewController, didUpdateFilters filters: [String: AnyObject])
}

class FiltersViewController: UIViewController {
    
    var filters:Filters!
    var filterSwitchStates = [Int:[Int:Bool]]()
    
    let filtersCellId = "com.vnu.FilterTableViewCell"
    
    weak var delegate:FiltersViewControllerDelegate?

    @IBOutlet var filtersTableView: UITableView!

    
    override func viewDidLoad() {
        filters = Filters()
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func onCancelTapped(sender: UIBarButtonItem) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func onApplyTapped(sender: UIBarButtonItem) {
        
        dismissViewControllerAnimated(true, completion: nil)
        
        var chosenFilters = [String: AnyObject]()
        
        var selectedCategories = [String]()
        
        
        for(currentSection, currentFilter) in filterSwitchStates{
            let sectionTitle = filters.sectionTitles[currentSection]
            let  filterSection = filters.sectionAtIndex(currentSection)

            for(row, isSelected) in currentFilter{
                
                if(isSelected){
                    selectedCategories.append(filterSection[row]["code"]!)
                }
            }
            chosenFilters[sectionTitle] = selectedCategories
        }
        print(chosenFilters)
        delegate?.filtersViewController?(self, didUpdateFilters: chosenFilters)

     
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

extension FiltersViewController:UITableViewDataSource, UITableViewDelegate, FilterTableViewCellDelegate{
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return filters.sectionTitles.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(filtersCellId, forIndexPath: indexPath) as! FilterTableViewCell
        cell.delegate = self
        let filterSection = filters.sectionAtIndex(indexPath.section)
        cell.filterLabel.text = filterSection[indexPath.row]["name"]
        if let currentSection = filterSwitchStates[indexPath.section]{
            cell.filterOnSwitch.on = currentSection[indexPath.row] ?? false
        }else{
            cell.filterOnSwitch.on = false
        }
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filters.sectionAtIndex(section).count
    }
    
    func filterTableViewCell(filterTableViewCell: FilterTableViewCell, didChangeValue value: Bool) {
        let indexPath = filtersTableView.indexPathForCell(filterTableViewCell)!
        if filterSwitchStates[indexPath.section] != nil{
            var cellSwitchState = filterSwitchStates[indexPath.section]
            cellSwitchState![indexPath.row] = value
            filterSwitchStates[indexPath.section] = cellSwitchState
        }else{
            var cellSwitchState = [Int: Bool]()
            cellSwitchState[indexPath.row] = value
            filterSwitchStates[indexPath.section] = cellSwitchState
        }
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return filters.sectionTitles[section]
    }
}
