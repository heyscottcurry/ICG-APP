//
//  CoffeeShop.swift
//  Indianapolis Coffee Guide
//
//  Created by Scott Curry on 3/4/17.
//  Copyright © 2017 Scott Curry. All rights reserved.
//

import Foundation
import UIKit
import MapKit
import CoreLocation

class CoffeeShop {
    //MARK: properties
    

    var name: String
    var neighborhood: String
    var long: Double
    var lat: Double
    var listBrew: String
    var listSpace: String
    var feature: UIImage?
    var newShop: Bool
    var igHandle: String
    var distance: Double
    var googleMap: String
    var appleMap: String
    
    
    init(name: String, neighborhood: String, long: Double, lat: Double, listBrew: String, listSpace: String, feature: UIImage?, newShop: Bool, igHandle: String, distance: Double, googleMap: String, appleMap: String) {
        
        
        
        // Initialize stored properties.
        self.name = name
        self.neighborhood = neighborhood
        self.long = long
        self.lat = lat
        self.listBrew = listBrew
        self.listSpace = listSpace
        self.feature = feature
        self.newShop = newShop
        self.igHandle = igHandle
        self.distance = distance
        self.googleMap = googleMap
        self.appleMap = appleMap
        
    }

}



//MARK: Initialization


