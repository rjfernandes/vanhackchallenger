//
//  OrderCell.swift
//  Hackaton
//
//  Created by Robson Fernandes on 17/03/18.
//  Copyright © 2018 Robson Fernandes. All rights reserved.
//

import UIKit

class OrderCell: UITableViewCell {
    
    @IBOutlet weak var storeNameLabel: UILabel!
    @IBOutlet weak var orderLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!

    var item: StoreOrder! {
        didSet {
            storeNameLabel.text = item.store.name
            orderLabel.text = item.orders.count == 1 ? "There is 1 product in this order" : "There are \(item.orders.count) products in this order"
            totalLabel.text = item.orders.map({ $0.total }).reduce(0.0, +).currency
        }
    }
    
}
