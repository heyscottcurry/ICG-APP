//
//  LaunchVC.swift
//  Indianapolis Coffee Guide
//
//  Created by Scott Curry on 3/12/17.
//  Copyright © 2017 Scott Curry. All rights reserved.
//

import UIKit

class LaunchVC: UIViewController {
    
    
    @IBAction func getStarted(_ sender: UIButton) {
    }

    @IBOutlet weak var getStartedBtn: UIButton!

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        self.getStartedBtn.layer.borderWidth = 2
        self.getStartedBtn.layer.borderColor = UIColor.white.cgColor
        
        
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:)))
        tap.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tap)
    
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
