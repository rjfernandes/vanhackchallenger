//
//  OrderItem.swift
//  Hackaton
//
//  Created by Robson Fernandes on 17/03/18.
//  Copyright © 2018 Robson Fernandes. All rights reserved.
//

import Foundation

struct OrderItem: Encodable, Equatable {
    static func ==(lhs: OrderItem, rhs: OrderItem) -> Bool {
        return lhs.orderId == rhs.orderId
    }
    
    let id: Int64
    let orderId: Int64
    let productId: Int64
    let price: Double
    let quantity: Int64
    let total: Double
    let product: ProductResponseModel
    
    init(product: ProductResponseModel, quantity: Int64 = 1) {
        self.product = product
        id = 0
        orderId = 0
        productId = product.id
        price = product.price
        self.quantity = quantity
        total = price * Double(quantity)
    }
}
