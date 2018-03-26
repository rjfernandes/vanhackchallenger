//
//  StoreContract.swift
//  Hackaton
//
//  Created by Robson Fernandes on 17/03/18.
//  Copyright © 2018 Robson Fernandes. All rights reserved.
//

import Foundation

protocol StoreViewContract: BaseViewContract {
    func populateTab(cousines: [CousineModel])
    func populate(items: [StoreItem])
    func gotoProducts(store: StoreItem)
    func logout()
}

protocol StorePresenterContract: BasePresenterContract {
    func requestCousines()
    func requestStoresBy(cousine: CousineModel)
    func openProducts(store: StoreItem)
    func logout()
}
