//
//  noLocation.swift
//  Indianapolis Coffee Guide
//
//  Created by Scott Curry on 7/7/17.
//  Copyright © 2017 Scott Curry. All rights reserved.
//

import UIKit
import CoreLocation

class noLocation: UIViewController, CLLocationManagerDelegate {
    


    @IBOutlet weak var openSettings: UIButton!
    @IBOutlet weak var allowNow: UIButton!
    
    
    var locationManager = CLLocationManager()
    
    @IBAction func allowLocale(_ sender: UIButton) {
    
    
    self.locationManager = CLLocationManager()
    self.locationManager.delegate = self
    locationManager.requestWhenInUseAuthorization()
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
    if status == .authorizedWhenInUse {
    self.performSegue(withIdentifier: "wereIn", sender: self)
    } else if status == .denied {
        self.openSettings.alpha = 1
        self.allowNow.alpha = 0
        }
        
    }
    

    
    @IBAction func openSettings(_ sender: UIButton) {
        
        if let appSettings = NSURL(string: UIApplicationOpenSettingsURLString) {
            UIApplication.shared.open(appSettings as URL)
        }
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if CLLocationManager.authorizationStatus() == .notDetermined {
            self.openSettings.alpha = 0
            self.allowNow.alpha = 1
        } else if CLLocationManager.authorizationStatus() == .denied {
            self.openSettings.alpha = 1
            self.allowNow.alpha = 0
        }

    
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    



}
