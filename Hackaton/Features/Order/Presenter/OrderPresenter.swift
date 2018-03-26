//
//  OrderPresenter.swift
//  Hackaton
//
//  Created by Robson Fernandes on 17/03/18.
//  Copyright © 2018 Robson Fernandes. All rights reserved.
//

import Foundation

class OrderPresenter: BasePresenter<OrderViewContract>, OrderPresenterContract {
    
    lazy var orderAPI = OrderAPI()
    
    func request() {
        view.populate(items: orders)
    }
    
    func place(orders items: [StoreOrder]) {
        if items.isEmpty {
            view.show(error: "You must pick, at least, 1 order")
            return
        }
        
        guard profile?.name != nil else {
            view.requestAddress(orders: items)
            return
        }
        
        orderAPI.placeOrders(items: items) { (_, error) in
            if let error = error?.localizedDescription {
                self.view.show(error: error)
            }
            else {
                orders.removeAll()
                self.view.populate(items: [])
                self.view.success()
            }
        }
    }
    
}
