//
//  textFields.swift
//  GooglemapTest
//
//  Created by Cyberk on 3/23/17.
//  Copyright © 2017 Cyberk. All rights reserved.
//

import UIKit


extension UITextField{
    @IBInspectable var placeHolderColor: UIColor? {
        get {
            return self.placeHolderColor
        }
        set {
            self.attributedPlaceholder = NSAttributedString(string:self.placeholder != nil ? self.placeholder! : "Drop Location", attributes:[NSForegroundColorAttributeName: newValue!])
        }
    }
}
