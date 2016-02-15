//
//  FilterTableViewCell.swift
//  YelpMe
//
//  Created by Vinu Charanya on 2/13/16.
//  Copyright © 2016 Vnu. All rights reserved.
//

import UIKit

@objc protocol FilterTableViewCellDelegate {
    optional func filterTableViewCell(filterTableViewCell: FilterTableViewCell, didChangeValue value: Bool)
}

class FilterTableViewCell: UITableViewCell {
    
    weak var delegate: FilterTableViewCellDelegate?
    
    @IBOutlet weak var filterLabel: UILabel!
    
    @IBOutlet weak var filterOnSwitch: UISwitch!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func filterOnSwitchChanged(sender: UISwitch) {
        print("filterSwitchChanged")
        delegate?.filterTableViewCell?(self, didChangeValue: filterOnSwitch.on)
    }
    

}
