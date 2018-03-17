//
//  AddressPresenter.swift
//  Hackaton
//
//  Created by Robson Fernandes on 17/03/18.
//  Copyright © 2018 Robson Fernandes. All rights reserved.
//

import Foundation

class AddressPresenter: BasePresenter<AddressViewContract>, AddressPresenterContract {
    
    private var orders = [OrderItem]()
    
    func set(pickedOrders: [OrderItem]) {
        orders += pickedOrders
    }
    
    func placeOrders(contactName: String?, deliveryAddress: String?) {
        guard let contactName = contactName?.trimmingCharacters(in: .whitespacesAndNewlines), let deliveryAddress = deliveryAddress?.trimmingCharacters(in: .whitespacesAndNewlines), contactName.count > 0 && deliveryAddress.count > 0 else {
            view.show(error: "You must provide a contact name and an delivery address")
            return
        }
        
        let total = orders.map({ $0.price }).reduce(0.0, +)
        
        let lastDate = Date().w3c
        
        let placeOrder = OrderRequestModel(id: 0, date: lastDate, customerId: 0, deliveryAddress: deliveryAddress, contact: contactName, storeId: 0, orderItems: orders, total: total, status: "", lastUpdate: lastDate)
        
        authAPI.request(placeOrder, method: .post) { (result: String?, error) in
            if let error = error?.localizedDescription {
                self.view.show(error: error)
            }
            else {
                self.view.success()
            }
        }
    }
    
    
    
    
    
}
