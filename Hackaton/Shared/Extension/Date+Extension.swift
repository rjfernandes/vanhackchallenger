//
//  Date+Extension.swift
//  Hackaton
//
//  Created by Robson Fernandes on 17/03/18.
//  Copyright © 2018 Robson Fernandes. All rights reserved.
//

import Foundation
import SwiftDate

struct DateMasks {
    static let W3C = "yyyy-MM-dd'T'HH:mm:ss.SSS'z'"
    static let HUMAN_READABLE = "MM/dd/yyyy HH:mm"
}

extension Date {
    func format(mask: String) -> String {
        return string(format: .custom(mask))
    }
    
    var w3c: String {
        return format(mask: DateMasks.W3C)
    }
    
    var humanReadable: String {
        return format(mask: DateMasks.HUMAN_READABLE)
    }
}

extension String {
    func parse(mask: String = DateMasks.W3C) -> Date? {
        if (self.trimmingCharacters(in: .whitespacesAndNewlines).count == 0) {
            return nil
        }
        
        let brazil = Region(tz: .americaSaoPaulo, cal: .gregorian, loc: .portugueseBrazil)
        let dateRegion = DateInRegion(string: self, format: .custom(mask), fromRegion: brazil)
        return dateRegion?.absoluteDate
    }
}
