//
//  BusinessesInfoViewController.swift
//  Yelp
//
//  Created by Cory Avra on 2/13/16.
//  Copyright © 2016 Timothy Lee. All rights reserved.
//

import UIKit

class BusinessesInfoViewController: UIViewController {

    // Outlets
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var ratingsImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var categoriesLabel: UILabel!
    @IBOutlet weak var ratingsCountLabel: UILabel!
    
    // Variables
    var business: Business!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        displayBusinessInfo()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func displayBusinessInfo() {
        if (business.imageURL != nil ) {
            backgroundImageView.setImageWithURL(business.imageURL!)
        }
        if (business.ratingImageURL != nil ) {
            ratingsImageView.setImageWithURL(business.ratingImageURL!)
        }
        nameLabel.text = business.name
        distanceLabel.text = business.distance
        addressLabel.text = business.address
        categoriesLabel.text = business.categories
        if (business.reviewCount! == 1) {
            ratingsCountLabel.text = "\(business.reviewCount!) Review"
        }
        else {
            ratingsCountLabel.text = "\(business.reviewCount!) Reviews"
        }
    }
}