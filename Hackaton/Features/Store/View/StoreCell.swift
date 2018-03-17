//
//  StoreCell.swift
//  Hackaton
//
//  Created by Robson Fernandes on 17/03/18.
//  Copyright © 2018 Robson Fernandes. All rights reserved.
//

import UIKit

class StoreCell: UITableViewCell {

    @IBOutlet weak var storeNameLabel: UILabel!
    @IBOutlet weak var storeAddressLabel: UILabel!

    var item: StoreItem! {
        didSet {
            storeNameLabel.text = item.name
            storeAddressLabel.text = item.address
        }
    }
    
}
