//
//  StoreOrder.swift
//  Hackaton
//
//  Created by Robson Fernandes on 17/03/18.
//  Copyright © 2018 Robson Fernandes. All rights reserved.
//

import Foundation

class StoreOrder {
    var store: StoreItem
    var order: OrderItem
    
    init(store: StoreItem, order: OrderItem) {
        self.store = store
        self.order = order
    }
}
