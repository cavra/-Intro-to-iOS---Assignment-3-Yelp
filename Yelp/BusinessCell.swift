//
//  BusinessCell.swift
//  Yelp
//
//  Created by Cory Avra on 2/8/16.
//  Copyright © 2016 Timothy Lee. All rights reserved.
//

import UIKit

class BusinessCell: UITableViewCell {

    // Outlets
    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var ratingsImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var categoriesLabel: UILabel!
    @IBOutlet weak var ratingCountLabel: UILabel!
    
    // Variables
    var business: Business! {
        didSet {
            if (business.imageURL != nil ) {
                thumbnailImageView.setImageWithURL(business.imageURL!)
            }
            if (business.ratingImageURL != nil ) {
                ratingsImageView.setImageWithURL(business.ratingImageURL!)
            }
            nameLabel.text = business.name
            distanceLabel.text = business.distance
            addressLabel.text = business.address
            categoriesLabel.text = business.categories
            if (business.reviewCount! == 1) {
                ratingCountLabel.text = "\(business.reviewCount!) Review"
            }
            else {
                ratingCountLabel.text = "\(business.reviewCount!) Reviews"
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Some formatting
        thumbnailImageView.layer.cornerRadius = 3
        thumbnailImageView.clipsToBounds = true
        
        nameLabel.preferredMaxLayoutWidth = nameLabel.frame.size.width
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        nameLabel.preferredMaxLayoutWidth = nameLabel.frame.size.width
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Set the default first
        let backgroundView = UIView()
        backgroundView.backgroundColor = .None
        self.backgroundView = backgroundView
        
        // Followed by the selected style
        let selectedBackgroundView = UIView()
        selectedBackgroundView.backgroundColor = UIColor.lightGrayColor()
        self.selectedBackgroundView = selectedBackgroundView
    }
}
