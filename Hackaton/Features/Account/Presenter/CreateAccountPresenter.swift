//
//  CreateAccountPresenter.swift
//  Hackaton
//
//  Created by Robson Fernandes on 17/03/18.
//  Copyright © 2018 Robson Fernandes. All rights reserved.
//

import Foundation


class AccountPresenter: BasePresenter<AccountViewContract>, AccountPresenterContract {
    
    func store(name: String?, email: String?, address: String?, password: String?, repeatPassword: String?) {
        guard
            let name = name?.trimmingCharacters(in: .whitespacesAndNewlines),
            let email = email?.trimmingCharacters(in: .whitespacesAndNewlines),
            let address = address?.trimmingCharacters(in: .whitespacesAndNewlines),
            let password = password?.trimmingCharacters(in: .whitespacesAndNewlines),
            let repeatPassword = repeatPassword?.trimmingCharacters(in: .whitespacesAndNewlines),
            name.count > 0 &&
            email.count > 0 &&
            address.count > 0 &&
            password.count > 0 &&
            repeatPassword.count > 0
        else {
            view.show(error: "You must fill all fields")
            return
        }
        
        if repeatPassword != password {
            view.show(error: "Passwords must be equals")
            return
        }
        
        let accountRequest = AccountRequestModel(id: 0, email: email, name: name, address: address, creation: Date().w3c, password: password)
        unauthAPI.request(accountRequest, method: .post) { (token: String?, error) in
            if let error = error?.localizedDescription {
                self.view.show(error: error)
            }
            else if let token = token {
                self.store(user: accountRequest, token: token)
            }
        }
    }
    
    private func store(user: AccountRequestModel, token: String) {
        CheckUserLoggedService().store(token: token, user: user)
        view.success()
    }
 }
