//
//  LoginAPI.swift
//  Hackaton
//
//  Created by Robson Fernandes on 17/03/18.
//  Copyright © 2018 Robson Fernandes. All rights reserved.
//

import Foundation

class LoginAPI: UnauthenticateAPI {
    
    func login(email: String, password: String, completion: @escaping (String?, HackathonAPIError?) -> Void)  {
        let reqEndpoint = "Customer/auth?email=\(email)&password=\(password)"
        requestData(endpoint: reqEndpoint, method: .post, dictionary: [:]) { data, error in
            if let data = data, let token = String(data: data, encoding: .utf8) {
                completion(token, nil)
            }
            else {
                completion(nil, error)
            }
        }
    }
    
}
