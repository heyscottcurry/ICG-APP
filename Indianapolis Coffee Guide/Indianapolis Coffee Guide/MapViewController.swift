//
//  MapViewController.swift
//  Indianapolis Coffee Guide
//
//  Created by Scott Curry on 3/8/17.
//  Copyright © 2017 Scott Curry. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController {
    
    @IBOutlet weak var directButton: UIButton!
    @IBOutlet weak var closeButton: UIButton!
    
    @IBOutlet weak var shopMap: MKMapView!
    
    
    
    var array = CoffeeShopTableViewCell
    
    var detailShop: CoffeeShop!  {
         didSet {
            configureView()
        }
    }
    
    
    
    
  func configureView() {
         let detailShop = self.detailShop
    }
 
    

    override func viewDidLoad() {
        super.viewDidLoad()
          configureView()
        
        
        // let location = CLLocationCoordinate2DMake((detailShop?.long)!, (detailShop?.lat)!)
        let location = CLLocationCoordinate2DMake(39.970128, -86.128349)
        
        
        let annotation = MKPointAnnotation()
        /*   let shopName = String(detailShop.name)
       
      annotation.title = (shopName)*/
       
        shopMap.addAnnotation(annotation)
        
        print(detailShop?.name)
        
        
        annotation.coordinate = location
        
        self.directButton.layer.borderWidth = 2
        self.directButton.layer.borderColor = UIColor.white.cgColor
        self.closeButton.layer.borderWidth = 2
        self.closeButton.layer.borderColor = UIColor.white.cgColor
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
