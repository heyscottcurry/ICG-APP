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
    var mondayOpen: Double
    var mondayClose: Double
    var tuesdayOpen: Double
    var tuesdayClose: Double
    var wednesdayOpen: Double
    var wednesdayClose: Double
    var thursdayOpen: Double
    var thursdayClose: Double
    var fridayOpen: Double
    var fridayClose: Double
    var saturdayOpen: Double
    var saturdayClose: Double
    var sundayOpen: Double
    var sundayClose: Double
    var isOpen: Bool
    var isFave: Bool
    
    init(name: String, neighborhood: String, long: Double, lat: Double, listBrew: String, listSpace: String, feature: UIImage?, newShop: Bool, igHandle: String, distance: Double, googleMap: String, appleMap: String, mondayOpen: Double, mondayClose: Double, tuesdayOpen: Double, tuesdayClose: Double, wednesdayOpen: Double, wednesdayClose: Double, thursdayOpen: Double, thursdayClose: Double, fridayOpen: Double, fridayClose: Double, saturdayOpen: Double, saturdayClose: Double, sundayOpen: Double, sundayClose: Double, isOpen: Bool, isFave: Bool ) {
        
        
        
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
        self.mondayOpen = mondayOpen
        self.mondayClose = mondayClose
        self.tuesdayOpen = tuesdayOpen
        self.tuesdayClose = tuesdayClose
        self.wednesdayOpen = wednesdayOpen
        self.wednesdayClose = wednesdayClose
        self.thursdayOpen = thursdayOpen
        self.thursdayClose = thursdayClose
        self.fridayOpen = fridayOpen
        self.fridayClose = fridayClose
        self.saturdayOpen = saturdayOpen
        self.saturdayClose = saturdayClose
        self.sundayOpen = sundayOpen
        self.sundayClose = sundayClose
        self.isOpen = isOpen
        self.isFave = isFave
        
    }
    
}



//MARK: Initialization


