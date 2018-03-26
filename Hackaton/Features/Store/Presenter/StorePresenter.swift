//
//  StorePresenter.swift
//  Hackaton
//
//  Created by Robson Fernandes on 17/03/18.
//  Copyright © 2018 Robson Fernandes. All rights reserved.
//

import Foundation

class StorePresenter: BasePresenter<StoreViewContract>, StorePresenterContract {
    
    func requestCousines() {
        unauthAPI.requestFrom(endpoint: "Cousine") { (result: [CousineModel]?, error) in
            if let result = result {
                self.view.populateTab(cousines: result)
            }
            else if let error = error?.localizedDescription {
                self.view.show(error: error)
            }
        }
    }
    
    func requestStoresBy(cousine: CousineModel) {
        unauthAPI.requestFrom(endpoint: "Cousine/\(cousine.id)/stores") { (result: [StoreItem]?, error) in
            if let result = result {
                self.view.populate(items: result)
            }
            else if let error = error?.localizedDescription {
                self.view.show(error: error)
            }
        }
    }
    
    func openProducts(store: StoreItem) {
        view.gotoProducts(store: store)
    }
    
    func logout() {
        CheckUserLoggedService().logout()
        view.logout()
    }
}
