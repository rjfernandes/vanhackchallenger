//
//  LoginRequestModel.swift
//  Hackaton
//
//  Created by Robson Fernandes on 17/03/18.
//  Copyright © 2018 Robson Fernandes. All rights reserved.
//

import Foundation

struct LoginRequestModel: HackathonRequestProtocol {
    func endpoint() -> String {
        return "Customer/auth"
    }
    
    let email: String
    let password: String
}
