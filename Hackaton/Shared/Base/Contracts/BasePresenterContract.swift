//
//  BasePresenter.swift
//  Hackaton
//
//  Created by Robson Fernandes on 17/03/18.
//  Copyright © 2018 Robson Fernandes. All rights reserved.
//

import Foundation

protocol BaseViewContract {
    func showLoading()
    func hideLoading()
    func show(error: String)
}

protocol BasePresenterContract {
    
}
