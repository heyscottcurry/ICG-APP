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
    @IBOutlet weak var contactButton: UIButton!
    @IBOutlet weak var appsupportButton: UIButton!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        shopsButton.alpha = 0
        contactButton.alpha = 0
        appsupportButton.alpha = 0
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        UIView.animate(withDuration: 0.25, animations: {
            self.shopsButton.alpha = 1
        }) 
   

        UIView.animate(withDuration: 0.3, delay: 0.1, animations: {
            self.contactButton.alpha = 1
        })
    

       
        
    }
        
    
    

}
