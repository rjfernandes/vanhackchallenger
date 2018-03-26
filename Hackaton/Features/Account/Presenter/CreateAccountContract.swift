//
//  CreateAccountContract.swift
//  Hackaton
//
//  Created by Robson Fernandes on 17/03/18.
//  Copyright © 2018 Robson Fernandes. All rights reserved.
//

import Foundation

protocol AccountViewContract: BaseViewContract {
    func success()
}

protocol AccountPresenterContract: BasePresenterContract {
    func store(name: String?, email: String?, address: String?, password: String?, repeatPassword: String?)
}
