//
//  LoginPresenter.swift
//  Hackaton
//
//  Created by Robson Fernandes on 17/03/18.
//  Copyright © 2018 Robson Fernandes. All rights reserved.
//

import Foundation

class LoginPresenter: BasePresenter<LoginViewContract>, LoginContractPresenter {
    
    lazy var loginAPI = LoginAPI()
    
    override func start() {
        loginAPI.requestingObserver.subscribe(onNext: { value in
            if value {
                self.view.showLoading()
            }
            else {
                self.view.hideLoading()
            }
        }).disposed(by: disposeBag)
    }
    
    func login(email: String?, password: String?) {
        guard let email = email?.trimmingCharacters(in: .whitespacesAndNewlines), let password = password?.trimmingCharacters(in: .whitespacesAndNewlines), email.count > 0 && password.count > 0 else {
            view.show(error: "You must provide an email and password")
            return
        }
        
        loginAPI.login(email: email, password: password) { (token, error) in
            if let error = error?.localizedDescription {
                self.view.show(error: error)
            }
            else if let token = token {
                self.store(token: token)
                self.view.granteed()
            }
        }
    }
    
    private func store(token: String) {
        let userDefaults = UserDefaults()
        userDefaults.set(token, forKey: AppConfig.userTokenName)
        userDefaults.synchronize()
    }
    
    func createAccount() {
        view.gotoCreateAccount()
    }
    
}
