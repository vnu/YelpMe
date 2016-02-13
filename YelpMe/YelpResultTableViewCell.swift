//
//  YelpResultTableViewCell.swift
//  YelpMe
//
//  Created by Vinu Charanya on 2/12/16.
//  Copyright © 2016 vnu. All rights reserved.
//

import UIKit

class YelpResultTableViewCell: UITableViewCell {

    
    @IBOutlet weak var resultImageView: UIImageView!
    
    @IBOutlet weak var resultNameLabel: UILabel!
    
    @IBOutlet weak var reviewCountLabel: UILabel!
    
    @IBOutlet weak var reviewRatingImageView: UIImageView!
    
    @IBOutlet weak var resultCategoryLabel: UILabel!
    
    @IBOutlet weak var resultLocationLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
