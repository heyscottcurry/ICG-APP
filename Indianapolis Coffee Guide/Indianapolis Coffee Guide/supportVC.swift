//
//  supportVC.swift
//  Indianapolis Coffee Guide
//
//  Created by Scott Curry on 5/26/17.
//  Copyright © 2017 Scott Curry. All rights reserved.
//

import UIKit
import WebKit

class supportVC: UIViewController {


    
    @IBOutlet weak var supportWebView: WKWebView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = URL(string: "https://www.indianapoliscoffeeguide.com/support")
        supportWebView.load(URLRequest(url: url!))
        
    }
 

}
