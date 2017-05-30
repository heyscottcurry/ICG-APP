//
//  sponsorVC.swift
//  Indianapolis Coffee Guide
//
//  Created by Scott Curry on 5/29/17.
//  Copyright © 2017 Scott Curry. All rights reserved.
//

import UIKit
import WebKit

class sponsorVC: UIViewController {


    @IBOutlet weak var sponsorWebView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = URL(string: "https://www.indianapoliscoffeeguide.com/mobile-sponsor")
        sponsorWebView.load(URLRequest(url: url!))
        
    }

}
