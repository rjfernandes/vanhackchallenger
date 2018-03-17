//
//  StoreController.swift
//  Hackaton
//
//  Created by Robson Fernandes on 17/03/18.
//  Copyright © 2018 Robson Fernandes. All rights reserved.
//

import UIKit

class StoreController: BaseGenericTableViewController<StoreItem> {
    
    lazy var presenter = StorePresenter(view: self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.request()
        let btnLogout = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(logoutTap))
        navigationItem.rightBarButtonItem = btnLogout
        let btnOrders = UIBarButtonItem(title: "Orders", style: .plain, target: self, action: #selector(ordersTap))
        navigationItem.leftBarButtonItem = btnOrders
    }
    
    @objc func logoutTap() {
        confirm(message: "Logout?", style: .actionSheet) {
            if $0 {
                self.presenter.logout()
            }
        }
    }
    
    @objc func ordersTap() {
        push(controllerType: .orders)
    }
    
    override func picked(item: StoreItem) {
        presenter.openProducts(store: item)
    }
    
    override func custom(cell: UITableViewCell, with item: StoreItem) {
        (cell as? StoreCell)?.item = item
    }
}

extension StoreController: StoreViewContract {
    func gotoProducts(store: StoreItem) {
        push(controllerType: .products, hasOverlay: true) { (controller: ProductController) in
            controller.store = store
        }
    }
    
    func populate(items: [StoreItem]) {
        self.items += items
    }
    
    func show(error: String) {
        alert(message: error)
    }
    
    func showLoading() {
        
    }
    
    func hideLoading() {
        
    }
    
    func logout() {
        dismiss(animated: true, completion: nil)
    }

}
