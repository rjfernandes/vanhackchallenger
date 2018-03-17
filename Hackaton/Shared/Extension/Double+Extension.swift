//
//  Double+Extension.swift
//  Hackaton
//
//  Created by Robson Fernandes on 17/03/18.
//  Copyright © 2018 Robson Fernandes. All rights reserved.
//

import Foundation

extension Double {
    var currency: String {
        let formatter = NumberFormatter()
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        formatter.minimumIntegerDigits = 1
        formatter.decimalSeparator = ","
        formatter.groupingSeparator = "."
        
        let value = formatter.string(from: NSNumber(value: self)) ?? "0,00"
        return "C$ \(value)"
    }
}
