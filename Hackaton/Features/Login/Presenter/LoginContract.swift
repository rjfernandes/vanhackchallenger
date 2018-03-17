//
//  LoginContract.swift
//  Hackaton
//
//  Created by Robson Fernandes on 17/03/18.
//  Copyright © 2018 Robson Fernandes. All rights reserved.
//

import Foundation

protocol LoginViewContract: BaseViewContract {
    func granteed()
    func gotoCreateAccount()
}

protocol LoginContractPresenter: BasePresenterContract {
    func login(email: String?, password: String?)
    func createAccount()
}

