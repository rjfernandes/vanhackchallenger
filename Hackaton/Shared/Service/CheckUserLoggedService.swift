//
//  CheckUserLoggedService.swift
//  Hackaton
//
//  Created by Robson Fernandes on 17/03/18.
//  Copyright © 2018 Robson Fernandes. All rights reserved.
//

import Foundation

class CheckUserLoggedService {
    
    private lazy var userDefaults = UserDefaults()
    
    func token() -> String? {
        return userDefaults.value(forKey: AppConfig.userTokenName) as? String
    }
    
    func profile() -> AccountRequestModel? {
        guard let data = userDefaults.value(forKey: AppConfig.userData) as? Data else { return nil }
        return try? JSONDecoder().decode(AccountRequestModel.self, from: data)
    }
    
    func store(token: String, user: AccountRequestModel) {
        userDefaults.set(token, forKey: AppConfig.userTokenName)
        do {
            let data = try JSONEncoder().encode(user)
            userDefaults.set(data, forKey: AppConfig.userData)
        }
        catch { }
        userDefaults.synchronize()
    }
    
    func isLogged() -> Bool {
        return token() != nil
    }
    
    func logout() {
        userDefaults.removeObject(forKey: AppConfig.userTokenName)
        userDefaults.removeObject(forKey: AppConfig.userData)
    }
    
}
