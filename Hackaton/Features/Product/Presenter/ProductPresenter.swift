//
//  ProductPresenter.swift
//  Hackaton
//
//  Created by Robson Fernandes on 17/03/18.
//  Copyright © 2018 Robson Fernandes. All rights reserved.
//

import Foundation

class ProductPresenter: BasePresenter<ProductViewContract>, ProductPresenterContract {
    private var store: StoreItem!
    
    func set(store: StoreItem) {
        self.store = store
    }
    
    func request() {
        if !allProducts.isEmpty {
            filterByStore()
        }
        else {
            unauthAPI.requestFrom(endpoint: "Product", method: .get) { (products: [ProductResponseModel]?, error) in
                if let error = error {
                    self.view.show(error: error.localizedDescription)
                }
                else if let products = products {
                    allProducts += products
                    self.filterByStore()
                }
            }
        }
    }
    
    private func filterByStore() {
        self.view.populate(products: allProducts.filter({ $0.storeId == store.id }))
    }
    
    func createOrder(cart: [ProductResponseModel]) {
        let orderItems = cart.map({ OrderItem(product: $0) })
        orders += [ StoreOrder(store: store, orders: orderItems) ]
        view.backToStores()
    }
    
}
