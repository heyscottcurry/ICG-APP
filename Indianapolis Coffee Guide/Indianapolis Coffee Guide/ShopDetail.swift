//
//  ShopDetail.swift
//  Indianapolis Coffee Guide
//
//  Created by Scott Curry on 3/4/17.
//  Copyright © 2017 Scott Curry. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ShopDetail: UIViewController {

    @IBOutlet weak var directionsButton: UIButton!
   
    @IBOutlet weak var closeButton: UIButton!

    @IBOutlet weak var navTitle: UINavigationItem!
    @IBOutlet weak var shopNavTitle: UILabel!
    @IBOutlet weak var shopImage: UIImageView!
    @IBOutlet weak var borderMain: UIView!
    
    @IBOutlet weak var shopDistance: UILabel!
    
    var detailShop: CoffeeShop? {
        didSet {
            configureView()
        }
    }
    

    
    
    func configureView() {
        if let detailShop = detailShop {
            if let shopNavTitle = shopNavTitle{
                shopNavTitle.text =  detailShop.name
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        self.title = detailShop?.name
        self.shopImage.image = detailShop?.feature
        /* self.shopImage.contentMode = .scaleAspectFit */
        self.shopDistance.text = detailShop?.neighborhood
        
        self.borderMain.layer.borderWidth = 2
        self.borderMain.layer.borderColor = UIColor(red:255/255.0, green:225/255.0, blue:255/255.0, alpha: 1.0).cgColor
        self.directionsButton.layer.borderWidth = 2
        self.directionsButton.layer.borderColor = UIColor(red:255/255.0, green:225/255.0, blue:255/255.0, alpha: 1.0).cgColor
        self.closeButton.layer.borderWidth = 2
        self.closeButton.layer.borderColor = UIColor(red:255/255.0, green:225/255.0, blue:255/255.0, alpha: 1.0).cgColor
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

}

