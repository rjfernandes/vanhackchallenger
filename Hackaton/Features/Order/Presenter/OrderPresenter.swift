//
//  OrderPresenter.swift
//  Hackaton
//
//  Created by Robson Fernandes on 17/03/18.
//  Copyright © 2018 Robson Fernandes. All rights reserved.
//

import Foundation

class OrderPresenter: BasePresenter<OrderViewContract>, OrderPresenterContract {
    
    func request() {
        view.populate(items: orders)
    }
    
    func place(orders items: [StoreOrder]) {
        if items.isEmpty {
            view.show(error: "You must pick, at least, 1 order")
            return
        }
        
        guard let store = items.first else { return }
        
        let orderItems = items.map({ $0.order })
        let total = orderItems.map({ $0.price }).reduce(0.0, +)
        
        let orderRequest = OrderRequestModel(id: 0, date: Date().w3c, customerId: profile?.id ?? 0, deliveryAddress: profile?.address ?? "", contact: profile?.name ?? "", storeId: store.store.id, orderItems: orderItems, total: total, status: "", lastUpdate: Date().w3c)
        
        authAPI.request(orderRequest, method: .post) { (result: String?, error) in
            if let error = error {
                self.view.show(error: error.localizedDescription)
            }
            else {
                orders.removeAll()
                self.view.populate(items: [])
                self.view.success()
            }
        }
    }
    
}
