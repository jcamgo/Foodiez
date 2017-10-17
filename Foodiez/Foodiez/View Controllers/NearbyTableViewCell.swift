//
//  NearbyTableViewCell.swift
//  Foodiez
//
//  Created by jonathan orellana on 10/16/17.
//  Copyright © 2017 jonathan orellana. All rights reserved.
//

import UIKit

class NearbyTableViewCell: UITableViewCell {

    // MARK: - Properties
    @IBOutlet weak var photImageView: UIImageView!
    @IBOutlet weak var restaurantNameLabel: UILabel!
    @IBOutlet weak var foodNameLabel: UILabel!
    @IBOutlet weak var ratingControl: RatingControl!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }



}
