//
//  UIView.swift
//  FoodCodeScanner
//
//  Created by Vasyl Fuchenko on 6/6/20.
//  Copyright © 2020 Vasyl Fuchenko. All rights reserved.
//

import UIKit

extension UIView {
    class var identifier: String {
        return String(describing: self)
    }
    
    class var nib: UINib {
        return UINib(nibName: identifier, bundle: Bundle(for: self))
    }
    
    func closeBuuton() {
        print("sad")
    }
}
