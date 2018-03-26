//
//  UITextField+Extension.swift
//  Hackaton
//
//  Created by Robson Fernandes on 24/03/18.
//  Copyright © 2018 Robson Fernandes. All rights reserved.
//

import UIKit

extension UITextField {

    func setPaddingLeft(value: CGFloat = 8) {
        leftViewMode = .always
        leftView = UIView(frame: CGRect(x: 0, y: 0, width: value, height: 8))
    }
    
}
