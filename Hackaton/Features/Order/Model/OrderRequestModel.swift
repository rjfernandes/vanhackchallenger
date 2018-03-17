//
//  OrderRequestModel.swift
//  Hackaton
//
//  Created by Robson Fernandes on 17/03/18.
//  Copyright © 2018 Robson Fernandes. All rights reserved.
//

import Foundation

struct OrderRequestModel: HackathonRequestProtocol, Equatable {
    
    static func ==(lhs: OrderRequestModel, rhs: OrderRequestModel) -> Bool {
        return lhs.id == rhs.id
    }
    
    func endpoint() -> String {
        return "Order"
    }

    let id: Int64
    let date: String
    let customerId: Int64
    let deliveryAddress: String
    let contact: String
    let storeId: Int64
    let orderItems: [OrderItem]
    let total: Double
    let status: String
    let lastUpdate: String
    
}
