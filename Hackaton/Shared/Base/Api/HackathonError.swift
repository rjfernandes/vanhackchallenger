//
//  HackathonAPIError.swift
//  Hackaton
//
//  Created by Robson Fernandes on 17/03/18.
//  Copyright © 2018 Robson Fernandes. All rights reserved.
//

import Foundation

enum HackathonAPIError: Error {
    case success
    case error(String)
    
    var localizedDescription: String {
        switch self {
            case .success:
                return ""
            case .error(let strError):
                return strError
        }
    }
}

struct HackathonErrorModel: Decodable {
    let error: String
}
