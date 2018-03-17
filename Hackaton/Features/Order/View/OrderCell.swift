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
            orderLabel.text = item.order.product.count == 1 ? "There is 1 product in this order" : "There are \(item.order.product.count) products in this order"
            totalLabel.text = item.order.product.map({ $0.price }).reduce(0.0, +).currency
        }
    }
    
}
