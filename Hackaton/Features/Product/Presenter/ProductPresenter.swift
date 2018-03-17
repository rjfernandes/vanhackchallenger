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
        let orderItem = OrderItem(id: 0, orderId: 0, productId: 0, price: 0.0, quantity: Int64(cart.count), total: cart.map({ $0.price }).reduce(0.0, +), product: cart)

        orders += [ StoreOrder(store: store, order: orderItem) ]
        
        view.backToStores()
    }
    
}
