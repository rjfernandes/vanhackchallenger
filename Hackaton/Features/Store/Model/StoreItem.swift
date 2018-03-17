//
//  StoreItem.swift
//  Hackaton
//
//  Created by Robson Fernandes on 17/03/18.
//  Copyright © 2018 Robson Fernandes. All rights reserved.
//

import Foundation

struct StoreItem: Decodable, Equatable {
    static func ==(lhs: StoreItem, rhs: StoreItem) -> Bool {
        return lhs.id == rhs.id
    }

    let id: Int64
    let name: String
    let address: String
    let cousineId: Int64
}
