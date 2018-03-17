//
//  ProductCell.swift
//  Hackaton
//
//  Created by Robson Fernandes on 17/03/18.
//  Copyright © 2018 Robson Fernandes. All rights reserved.
//

import UIKit

class ProductCell: UITableViewCell {
    
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var productDescriptionLabel: UILabel!
    @IBOutlet weak var productPriceLabel: UILabel!
    
    var product: ProductResponseModel! {
        didSet {
            populate()
        }
    }
    
    private func populate() {
        productNameLabel.text = product.name
        productDescriptionLabel.text = product.description
        productPriceLabel.text = "   \(product.price.currency)  "
    }
}
