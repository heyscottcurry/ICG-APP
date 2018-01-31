//
//  shopNavVC.swift
//  Indianapolis Coffee Guide
//
//  Created by Scott Curry on 3/14/17.
//  Copyright © 2017 Scott Curry. All rights reserved.
//

import UIKit

class shopNavVC: UIViewController {
    
    
    @IBOutlet weak var downtownButton: UIButton!
    @IBOutlet weak var fsButton: UIButton!
    @IBOutlet weak var irvingtonButton: UIButton!
    @IBOutlet weak var brButton: UIButton!
    @IBOutlet weak var carmelButton: UIButton!
    @IBOutlet weak var fishersButton: UIButton!
    @IBOutlet weak var eaglecreekButton: UIButton!
    @IBOutlet weak var viewallButton: BorderButton!
   
    
    @IBAction func shopnavClose(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        downtownButton.alpha = 0
        fsButton.alpha = 0
        irvingtonButton.alpha = 0
        brButton.alpha = 0
        carmelButton.alpha = 0
        fishersButton.alpha = 0
        eaglecreekButton.alpha = 0
        viewallButton.alpha = 0
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
       
            UIView.animate(withDuration: 0.25, animations: {
                self.downtownButton.alpha = 1
            })


            UIView.animate(withDuration: 0.3, delay: 0.05, animations: {
                self.fsButton.alpha = 1
            })
        

            UIView.animate(withDuration: 0.3, delay: 0.1, animations: {
                self.irvingtonButton.alpha = 1
            })
        

            UIView.animate(withDuration: 0.3, delay: 0.15, animations: {
                self.brButton.alpha = 1
            })
        
        

            UIView.animate(withDuration: 0.3, delay: 0.2, animations: {
                self.carmelButton.alpha = 1
            })
        

            UIView.animate(withDuration: 0.3, delay: 0.25, animations: {
                self.fishersButton.alpha = 1
            })
        
        
            UIView.animate(withDuration: 0.3, delay: 0.3, animations: {
                self.eaglecreekButton.alpha = 1
            })
    
   
            UIView.animate(withDuration: 0.3, delay: 0.35, animations: {
                self.viewallButton.alpha = 1
            })
        
        }
        
    
    
    
    
}
