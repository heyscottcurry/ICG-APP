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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleImage.center = self.view.center
        getstartedBtn.alpha = 0
        sloganView.alpha = 0
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        UIView.animate(withDuration: 2.0, delay: 1.0, animations: {
            self.titleImage.frame.origin.y = self.view.frame.minY
        }) { (true) in
            UIView.animate(withDuration: 2.0, animations: {
                self.sloganView.alpha = 1
            })
            UIView.animate(withDuration: 2.0, delay: 2.0, animations: {
            self.getstartedBtn.alpha = 1
            })
        }
    }

    @IBAction func startBtn() {
        
        
        let stb = UIStoryboard(name: "Main", bundle: nil)
        let walkthrough = stb.instantiateViewController(withIdentifier: "walk0") as! BWWalkthroughViewController
        let page_one = stb.instantiateViewController(withIdentifier: "walk1") as UIViewController
        let page_two = stb.instantiateViewController(withIdentifier: "walk2") as UIViewController
        let page_three = stb.instantiateViewController(withIdentifier: "walk3") as UIViewController
        
        walkthrough.delegate = self
        walkthrough.add(viewController: page_one)
        walkthrough.add(viewController: page_two)
        walkthrough.add(viewController: page_three)
        
        present(walkthrough, animated: true, completion: nil)
        
        
        
    }

    
    
    
    
    

}
