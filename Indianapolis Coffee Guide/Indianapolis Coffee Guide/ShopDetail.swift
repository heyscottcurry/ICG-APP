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

   

    @IBOutlet weak var navTitle: UINavigationItem!
    @IBOutlet weak var shopNavTitle: UILabel!
    @IBOutlet weak var shopImage: UIImageView!
    
    
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
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

}

