//
//  contactVC.swift
//  Indianapolis Coffee Guide
//
//  Created by Scott Curry on 5/26/17.
//  Copyright © 2017 Scott Curry. All rights reserved.
//

import UIKit
import WebKit

class contactVC: UIViewController {


    @IBOutlet weak var contactWebView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = URL(string: "https://www.indianapoliscoffeeguide.com/mobile-contact")
       contactWebView.load(URLRequest(url: url!))
        
    }


}
