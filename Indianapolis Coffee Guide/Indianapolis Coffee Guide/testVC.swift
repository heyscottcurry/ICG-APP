//
//  testVC.swift
//  Indianapolis Coffee Guide
//
//  Created by Scott Curry on 5/30/17.
//  Copyright © 2017 Scott Curry. All rights reserved.
//

import UIKit

class testVC: UIViewController, BWWalkthroughViewControllerDelegate  {

    @IBOutlet weak var titleImage: UIImageView!
    @IBOutlet weak var getstartedBtn: BorderButton!
    @IBOutlet weak var sloganView: UIImageView!
    @IBOutlet weak var growBar: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleImage.center = self.view.center
        getstartedBtn.alpha = 0
        sloganView.alpha = 0
        growBar.alpha = 0
        
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        UIView.animate(withDuration: 1.5, delay: 1.0, animations: {
            self.titleImage.frame.origin.y = self.view.frame.minY
        }) { (true) in
            UIView.animate(withDuration: 1.5, animations: {
                self.sloganView.alpha = 1
            })
            UIView.animate(withDuration: 1.5, delay: 1.0, animations: {
            self.getstartedBtn.alpha = 1
            })
        }
    }

    @IBAction func startBtn() {
        
        self.growBar.alpha = 1
        UIView.animate(withDuration: 0.5, animations: {
            self.titleImage.alpha = 0
            self.sloganView.alpha = 0
            self.getstartedBtn.alpha = 0
            self.getstartedBtn.frame.origin.y = self.getstartedBtn.frame.origin.y + 100
            self.growBar.frame.size.height  = self.view.frame.size.height
            self.growBar.frame.origin.y = 0
            
            
        }) { (true) in
            
            let stb = UIStoryboard(name: "Main", bundle: nil)
            let walkthrough = stb.instantiateViewController(withIdentifier: "walk0") as! BWWalkthroughViewController
            let page_one = stb.instantiateViewController(withIdentifier: "walk1") as UIViewController
            let page_two = stb.instantiateViewController(withIdentifier: "walk2") as UIViewController
            let page_three = stb.instantiateViewController(withIdentifier: "walk3") as UIViewController
            let page_four = stb.instantiateViewController(withIdentifier: "walk4") as UIViewController
            
            walkthrough.delegate = self
            walkthrough.add(viewController: page_one)
            walkthrough.add(viewController: page_two)
            walkthrough.add(viewController: page_three)
            walkthrough.add(viewController: page_four)
            
            self.present(walkthrough, animated: true, completion: nil)
        }

        
        
        
    }

    
    
    
    
    

}
