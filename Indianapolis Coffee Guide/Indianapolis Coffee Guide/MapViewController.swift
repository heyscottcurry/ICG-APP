//
//  MapViewController.swift
//  Indianapolis Coffee Guide
//
//  Created by Scott Curry on 3/8/17.
//  Copyright © 2017 Scott Curry. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {
    
    @IBOutlet weak var directButton: UIButton!
    @IBOutlet weak var closeButton: UIButton!
    
    @IBOutlet weak var shopMap: MKMapView!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        
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
