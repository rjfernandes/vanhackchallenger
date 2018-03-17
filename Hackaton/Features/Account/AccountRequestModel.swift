//
//  AccountRequestModel.swift
//  Hackaton
//
//  Created by Robson Fernandes on 17/03/18.
//  Copyright © 2018 Robson Fernandes. All rights reserved.
//

import Foundation

struct AccountRequestModel: HackathonRequestProtocol, Decodable {
    func endpoint() -> String {
        return "Customer"
    }

    let id: Int64
    let email: String
    let name: String
    let address: String
    let creation: String
    let password: String
}
