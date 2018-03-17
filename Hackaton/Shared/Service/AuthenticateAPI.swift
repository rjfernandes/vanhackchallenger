//
//  AuthenticateAPI.swift
//  Hackaton
//
//  Created by Robson Fernandes on 17/03/18.
//  Copyright © 2018 Robson Fernandes. All rights reserved.
//

import Foundation

class AuthenticateAPI: HackathonAPI {
    
    override func headers() -> [String : String]? {
        if let token = UserDefaults().value(forKey: AppConfig.userTokenName) as? String {
            return ["Authentication" : "Bearer \(token)"]
        }
        return nil
    }
    
}
