//
//  AddressPresenter.swift
//  Hackaton
//
//  Created by Robson Fernandes on 17/03/18.
//  Copyright © 2018 Robson Fernandes. All rights reserved.
//

import Foundation

class AddressPresenter: BasePresenter<AddressViewContract>, AddressPresenterContract {
    
    lazy var orderAPI = OrderAPI()
    
    private var ordersToPlace = [StoreOrder]()
    
    func set(pickedOrders: [StoreOrder]) {
        ordersToPlace += pickedOrders
        view.set(contactName: profile?.name)
    }
    
    func placeOrders(contactName: String?, deliveryAddress: String?) {
        guard let contactName = contactName?.trimmingCharacters(in: .whitespacesAndNewlines), let deliveryAddress = deliveryAddress?.trimmingCharacters(in: .whitespacesAndNewlines), contactName.count > 0 && deliveryAddress.count > 0 else {
            view.show(error: "You must provide a contact name and an delivery address")
            return
        }
        
        orderAPI.contact = contactName
        orderAPI.address = deliveryAddress
        
        orderAPI.placeOrders(items: ordersToPlace) { (_, error) in
            if let error = error?.localizedDescription {
                self.view.show(error: error)
            }
            else {
                orders.removeAll()
                self.view.success()
            }
        }
    }
}
