//
//  menuView.swift
//  Indianapolis Coffee Guide
//
//  Created by Scott Curry on 5/26/17.
//  Copyright © 2017 Scott Curry. All rights reserved.
//

import UIKit

class menuView: UIViewController {

   
    @IBOutlet weak var shopsButton: UIButton!
    @IBOutlet weak var roastersButton: UIButton!
    @IBOutlet weak var roasterComingSoon: UIButton!
    @IBOutlet weak var aboutButton: UIButton!
    @IBOutlet weak var aboutComingSoon: UIButton!
    @IBOutlet weak var eventsButton: UIButton!
    @IBOutlet weak var eventsComingSoon: UIButton!
    @IBOutlet weak var blogButton: UIButton!
    @IBOutlet weak var blogComingSoon: UIButton!
    @IBOutlet weak var sponsorButton: UIButton!
    @IBOutlet weak var contactButton: UIButton!
    @IBOutlet weak var appsupportButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        shopsButton.alpha = 0
        roastersButton.alpha = 0
        roasterComingSoon.alpha = 0
        aboutButton.alpha = 0
        aboutComingSoon.alpha = 0
        eventsButton.alpha = 0
        eventsComingSoon.alpha = 0
        blogButton.alpha = 0
        blogComingSoon.alpha = 0
        sponsorButton.alpha = 0
        contactButton.alpha = 0
        appsupportButton.alpha = 0
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        UIView.animate(withDuration: 0.25, animations: {
            self.shopsButton.alpha = 1
        }) 
   

        UIView.animate(withDuration: 0.3, delay: 0.05, animations: {
            self.roastersButton.alpha = 0.55
            self.roasterComingSoon.alpha = 0.55
        })
    

        
        UIView.animate(withDuration: 0.3, delay: 0.1, animations: {
            self.aboutButton.alpha = 0.55
            self.aboutComingSoon.alpha = 0.55
        })
        
        
        UIView.animate(withDuration: 0.3, delay: 0.15, animations: {
            self.eventsButton.alpha = 0.55
            self.eventsComingSoon.alpha = 0.55
        })
        
        
        UIView.animate(withDuration: 0.3, delay: 0.2, animations: {
            self.blogButton.alpha = 0.55
            self.blogComingSoon.alpha = 0.55
        })
        

        UIView.animate(withDuration: 0.3, delay: 0.25, animations: {
            self.contactButton.alpha = 1
        })
    

        UIView.animate(withDuration: 0.3, delay: 0.3, animations: {
            self.sponsorButton.alpha = 1
            self.appsupportButton.alpha = 0.4
        })
        
    }
        
    
    

}
