//
//  thidOnboardVC.swift
//  Indianapolis Coffee Guide
//
//  Created by Scott Curry on 3/16/17.
//  Copyright © 2017 Scott Curry. All rights reserved.
//

import UIKit

class thidOnboardVC: UIViewController {
    @IBOutlet weak var nextButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.nextButton.layer.borderWidth = 2
        self.nextButton.layer.borderColor = UIColor(red:255/255.0, green:225/255.0, blue:255/255.0, alpha: 1.0).cgColor
        self.nextButton.alpha = 0
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        UIView.animate(withDuration: 2, animations: {
            self.nextButton.alpha = 1
            
        })
        
        
    }

}
