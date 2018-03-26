//
//  AddressContract.swift
//  Hackaton
//
//  Created by Robson Fernandes on 17/03/18.
//  Copyright © 2018 Robson Fernandes. All rights reserved.
//

import Foundation

protocol AddressViewContract: BaseViewContract {
    func set(contactName: String?)
    func success()
}

protocol AddressPresenterContract: BasePresenterContract {
    func set(pickedOrders: [StoreOrder])
    func placeOrders(contactName: String?, deliveryAddress: String?)
}
