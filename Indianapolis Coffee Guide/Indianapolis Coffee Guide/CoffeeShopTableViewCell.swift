//
//  CoffeeShopTableViewCell.swift
//  Indianapolis Coffee Guide
//
//  Created by Scott Curry on 3/4/17.
//  Copyright © 2017 Scott Curry. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class CoffeeShopTableViewCell: UITableViewCell {

    ///MARK: Properties
    
    
    @IBOutlet weak var featureThumbnail: UIImageView!
    @IBOutlet weak var shopNeighborhood: UILabel!
    @IBOutlet weak var shopDistance: UILabel!
    @IBOutlet weak var shopName: UILabel!
    
    @IBOutlet weak var cellBack: UIView!
  
 
    
   /* func viewDidLoad() {
        self.cellBack.backgroundColor = UIColor.blue
    
    } */
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
           // self.cellBack.backgroundColor = UIColor.red
            
    
        // Configure the view for the selected state
    }

}
