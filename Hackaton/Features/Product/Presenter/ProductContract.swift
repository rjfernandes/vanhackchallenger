//
//  ProductContract.swift
//  Hackaton
//
//  Created by Robson Fernandes on 17/03/18.
//  Copyright © 2018 Robson Fernandes. All rights reserved.
//

import Foundation


protocol ProductViewContract: BaseViewContract {
    func populate(products: [ProductResponseModel])
    func backToStores()
}

protocol ProductPresenterContract: BasePresenterContract {
    func set(store: StoreItem)
    func request()
    func createOrder(cart: [ProductResponseModel])
}
