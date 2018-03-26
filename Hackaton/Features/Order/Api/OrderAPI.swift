//
//  OrderAPI.swift
//  Hackaton
//
//  Created by Robson Fernandes on 23/03/18.
//  Copyright © 2018 Robson Fernandes. All rights reserved.
//

import Foundation

class OrderAPI: AuthenticateAPI {
    
    var contact: String?
    var address: String?
 
    func placeOrders(items: [StoreOrder], completion: @escaping (String?, HackathonAPIError?) -> Void) {
        guard let store = items.first else {
            completion(nil, .error("You must pick, at least, 1 order"))
            return
        }
        
        if items.first(where: { $0.store.id != store.store.id }) != nil {
            completion(nil, .error("You must to pick all orders from the same store"))
            return
        }
        
        let orderItems = items.flatMap({ $0.orders })
        let total = orderItems.map({ $0.price }).reduce(0.0, +)
        
        let orderRequest = OrderRequestModel(id: 0, date: Date().w3c, customerId: profile?.id ?? 0, deliveryAddress: profile?.address ?? address ?? "", contact: profile?.name ?? contact ?? "", storeId: store.store.id, orderItems: orderItems, total: total, status: "ORDERED", lastUpdate: Date().w3c)
        
        request(orderRequest, method: .post, completion: completion)
    }
    
}
