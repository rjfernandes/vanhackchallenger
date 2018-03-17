//
//  OrderContract.swift
//  Hackaton
//
//  Created by Robson Fernandes on 17/03/18.
//  Copyright © 2018 Robson Fernandes. All rights reserved.
//

import Foundation

protocol OrderViewContract: BaseViewContract {
    func populate(items: [StoreOrder])
    func success()
    func requestAddress()
}

protocol OrderPresenterContract: BasePresenterContract {
    func request()
    func place(orders items: [StoreOrder])
}
