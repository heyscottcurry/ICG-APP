//
//  CoffeeShopTableViewCell.swift
//  Indianapolis Coffee Guide
//
//  Created by Scott Curry on 3/4/17.
//  Copyright © 2017 Scott Curry. All rights reserved.
//

import UIKit
import MapKit

class CoffeeShopTableViewCell: UITableViewCell {

    ///MARK: Properties
    
    
    @IBOutlet weak var featureThumbnail: UIImageView!
    @IBOutlet weak var shopNeighborhood: UILabel!
    @IBOutlet weak var shopDistance: UILabel!
    @IBOutlet weak var shopName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
