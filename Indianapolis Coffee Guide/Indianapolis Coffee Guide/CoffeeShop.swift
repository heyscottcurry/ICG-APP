//
//  CoffeeShop.swift
//  Indianapolis Coffee Guide
//
//  Created by Scott Curry on 3/4/17.
//  Copyright © 2017 Scott Curry. All rights reserved.
//

import Foundation
import UIKit

class CoffeeShop {
    //MARK: properties
    
    var name: String
    var neighborhood: String
    var long: Double
    var lat: Double
    var listBrew: String
    var listSpace: String
    
    
    init(name: String, neighborhood: String, long: Double, lat: Double, listBrew: String, listSpace: String) {
        
        
        
        // Initialize stored properties.
        self.name = name
        self.neighborhood = neighborhood
        self.long = long
        self.lat = lat
        self.listBrew = listBrew
        self.listSpace = listSpace
        
        
    }

}



//MARK: Initialization


