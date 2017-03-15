//
//  MapPopoverVC.swift
//  Indianapolis Coffee Guide
//
//  Created by Scott Curry on 3/14/17.
//  Copyright © 2017 Scott Curry. All rights reserved.
//

import UIKit

class MapPopoverVC: UIViewController {


    @IBOutlet weak var appleMapButton: UIButton!
    @IBOutlet weak var mapButtons: UIButton!
    
    @IBOutlet weak var popoverVC: UIView!
    @IBAction func dismissMapVC(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
        
    }
    
    
    
    
    var detailShop: CoffeeShop!  {
        didSet {
            configureView()
        }
    }
    
    
    func configureView() {
        // let detailShop = self.detailShop
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        self.mapButtons.layer.borderWidth = 2
        self.mapButtons.layer.borderColor = UIColor.black.cgColor
        self.appleMapButton.layer.borderWidth = 2
        self.appleMapButton.layer.borderColor = UIColor.black.cgColor
        
 
    }
	

    @IBAction func appleMapButton(_ sender: Any) {
        
        if let url = NSURL(string: "\(detailShop.appleMap)"){
            UIApplication.shared.open(url as URL, options: [:], completionHandler: nil)
        }
        
        
    }

    
    @IBAction func mapButtons(_ sender: Any) {
   
        
        
       
        let instagramHooks = "comgooglemapsurl://\(detailShop.googleMap)"
        let instagramUrl = NSURL(string: instagramHooks)
        let fallbackURL = NSURL(string: "https://\(detailShop.googleMap)")
        if UIApplication.shared.canOpenURL(instagramUrl! as URL)
        {
            UIApplication.shared.open(instagramUrl! as URL, options: [:], completionHandler: nil)
            
            
        } else {
            //redirect to safari because the user doesn't have Instagram
            
            UIApplication.shared.open(fallbackURL! as URL, options: [:], completionHandler: nil)
            
        }
        
        
        
    }
    
    
    
}
