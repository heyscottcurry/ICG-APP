//
//  BorderButton.swift
//  Indianapolis Coffee Guide
//
//  Created by Scott Curry on 3/19/17.
//  Copyright © 2017 Scott Curry. All rights reserved.
//

import UIKit

@IBDesignable class BorderButton: UIButton {
    
    @IBInspectable var borderWidth: CGFloat = 0.0 {
    didSet {
    self.layer.borderWidth = borderWidth
    }
    }
    
    @IBInspectable var borderColor: UIColor = UIColor.clear {
        didSet {
            self.layer.borderColor = borderColor.cgColor
        }
    }
    
    

}
