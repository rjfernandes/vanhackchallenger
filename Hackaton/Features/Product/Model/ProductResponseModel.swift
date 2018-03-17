//
//  ProductResponseModel.swift
//  Hackaton
//
//  Created by Robson Fernandes on 17/03/18.
//  Copyright © 2018 Robson Fernandes. All rights reserved.
//

import Foundation

struct ProductResponseModel: Codable, Equatable {

    static func ==(lhs: ProductResponseModel, rhs: ProductResponseModel) -> Bool {
        return lhs.id == rhs.id
    }
    
    let id: Int
    let storeId: Int
    let name: String
    let description: String
    let price: Double
}
