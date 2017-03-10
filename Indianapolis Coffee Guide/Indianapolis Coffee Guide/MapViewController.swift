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
        
        
         let location = CLLocationCoordinate2DMake(detailShop.long, detailShop.lat)
       // let location = CLLocationCoordinate2DMake(39.970128, -86.128349)
        
        let span = MKCoordinateSpanMake(0.002, 0.002)
        let region = MKCoordinateRegion(center: location, span: span)
        
        shopMap.setRegion(region, animated: true)
        
        let annotation = MKPointAnnotation()
        let shopName = String(detailShop.name)
        annotation.title = (shopName)
       
        shopMap.addAnnotation(annotation)
        shopMap.selectAnnotation(annotation, animated: true)
        
        print(detailShop.name)
        
        
        annotation.coordinate = location
        
        self.directButton.layer.borderWidth = 2
        self.directButton.layer.borderColor = UIColor.black.cgColor
        self.closeButton.layer.borderWidth = 2
        self.closeButton.layer.borderColor = UIColor.black.cgColor
        
        
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
