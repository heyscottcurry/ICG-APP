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

    @IBOutlet weak var shopText: UITextView!

    @IBOutlet weak var brewText: UITextView!
    @IBOutlet weak var navTitle: UINavigationItem!
    @IBOutlet weak var shopNavTitle: UILabel!
    @IBOutlet weak var shopImage: UIImageView!
    @IBOutlet weak var borderMain: UIView!

    
    @IBOutlet weak var igButton: UIButton!
    
    
     var details = CoffeeShop.self
    
    @IBAction func igButt(_ sender: UIButton) {
        
        
        let instagramHooks = "instagram://user?username=\(detailShop!.igHandle)"
        let instagramUrl = NSURL(string: instagramHooks)
        let fallbackURL = NSURL(string: "https://www.instagram.com/\(detailShop!.igHandle)")
        if UIApplication.shared.canOpenURL(instagramUrl! as URL)
        {
            UIApplication.shared.open(instagramUrl! as URL, options: [:], completionHandler: nil)
            
            
        } else {
            //redirect to safari because the user doesn't have Instagram
            
            UIApplication.shared.open(fallbackURL! as URL, options: [:], completionHandler: nil)
            
        }
        

    }
   
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
        self.shopDistance.text = detailShop?.neighborhood
        self.shopText.text = detailShop?.listSpace
        self.brewText.text = detailShop?.listBrew
        
        
        
       igButton.setTitle("@\(detailShop!.igHandle)", for: UIControlState.normal)
        
        
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
    
    
    @IBAction func unwindToShop(segue: UIStoryboardSegue) {}
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "mapSegue" {
            
            let thirdVC = (segue.destination as! UINavigationController).topViewController as! MapViewController
            thirdVC.detailShop = detailShop
            
        }
        
    }

    
    
    
}

