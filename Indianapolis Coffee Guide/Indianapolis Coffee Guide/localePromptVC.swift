//
//  localePromptVC.swift
//  Indianapolis Coffee Guide
//
//  Created by Scott Curry on 6/1/17.
//  Copyright © 2017 Scott Curry. All rights reserved.
//

import UIKit
import CoreLocation

class localePromptVC: UIViewController, CLLocationManagerDelegate {
    
    
    var locationManager = CLLocationManager()

    @IBAction func allowLocale(_ sender: UIButton) {
        
       
        self.locationManager = CLLocationManager()
        self.locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
    }

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            self.performSegue(withIdentifier: "allowLocale", sender: self)
        } else if status == .denied {
            self.performSegue(withIdentifier: "updateLocale", sender: self)
        }
    }
 
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
  



}
