//
//  sponsorVC.swift
//  Indianapolis Coffee Guide
//
//  Created by Scott Curry on 5/29/17.
//  Copyright © 2017 Scott Curry. All rights reserved.
//

import UIKit
import WebKit

class sponsorVC: UIViewController{

    var activityIndication:UIActivityIndicatorView = UIActivityIndicatorView()
    @IBOutlet weak var sponsorWebView: WKWebView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        activityIndication.center = self.view.center
        activityIndication.hidesWhenStopped = true
        activityIndication.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        sponsorWebView.addSubview(activityIndication)
        
        activityIndication.startAnimating()
        
        let url = URL(string: "https://www.indianapoliscoffeeguide.com/mobile-sponsor")
        sponsorWebView.load(URLRequest(url: url!))
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        
        let when = DispatchTime.now() + 1 // change 2 to desired number of seconds
        DispatchQueue.main.asyncAfter(deadline: when) {
            UIView.animate(withDuration: 1, animations: {
                self.activityIndication.stopAnimating()
            })
        }
       
    }
    
    
}


