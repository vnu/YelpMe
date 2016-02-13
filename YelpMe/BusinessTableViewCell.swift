//
//  BusinessTableViewswift
//  YelpMe
//
//  Created by Vinu Charanya on 2/10/16.
//  Copyright © 2016 Vnu. All rights reserved.
//

import UIKit

class BusinessTableViewCell: UITableViewCell {
    
    @IBOutlet weak var businessImageView: UIImageView!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var categoriesLabel: UILabel!
    @IBOutlet weak var reviewCountLabel: UILabel!
    @IBOutlet weak var ratingsImageView: UIImageView!
    @IBOutlet weak var businessNameLabel: UILabel!
    
    @IBOutlet weak var distanceLabel: UILabel!
    
    var business: Business!{
        didSet{
            businessNameLabel.text = business.name!
            reviewCountLabel.text = "\(business.reviewCount!)"
            categoriesLabel.text = business.categories!
            addressLabel.text = business.location?.neighborhoods
            ratingsImageView.image = UIImage(named: "stars-\(business.rating!)")
            distanceLabel.text = business.distance!
            if let businessImage = business.imageUrl{
                businessImageView.setImageWithURL(NSURL(string: businessImage)!)
            }
            
        }
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
