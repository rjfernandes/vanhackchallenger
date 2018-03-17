//
//  OrderController.swift
//  Hackaton
//
//  Created by Robson Fernandes on 17/03/18.
//  Copyright © 2018 Robson Fernandes. All rights reserved.
//

import UIKit

class OrderController: BaseGenericTableViewController<StoreOrder> {
    
    var ordersPicked = [Int: StoreOrder]()
    
    lazy var presenter = OrderPresenter(view: self)
    var storeId: Int64 = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let btnCheckout = UIBarButtonItem(title: "Place Order(s)", style: .plain, target: self, action: #selector(placeOrder))
        navigationItem.rightBarButtonItem = btnCheckout
        presenter.request()
    }
    
    override func picked(item: StoreOrder, at indexPath: IndexPath) {
        if storeId != 0 && storeId != item.store.id {
            alert(message: "You must to pick all orders from the same store")
            return
        }
        if ordersPicked[indexPath.row] != nil {
            ordersPicked.removeValue(forKey: indexPath.row)
        }
        else {
            ordersPicked[indexPath.row] = item
        }
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
    
    override func custom(cell: UITableViewCell, with item: StoreOrder, at indexPath: IndexPath) {
        if let cell = cell as? OrderCell {
            cell.item = item
            cell.accessoryType = ordersPicked[indexPath.row] != nil ? .checkmark : .none
        }
    }
    
    @objc func placeOrder() {
        presenter.place(orders: ordersPicked.map({ _, value in value}))
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        orders.remove(at: indexPath.row)
        items.remove(at: indexPath.row)
    }
}

extension OrderController: OrderViewContract {
    func populate(items: [StoreOrder]) {
        self.items += items
    }
    
    func showLoading() {
        
    }
    
    func hideLoading() {
        
    }
    
    func show(error: String) {
        alert(message: error)
    }
    
    func success() {
        alert(message: "Orders placed successfully")
    }
    
    func requestAddress() {
        
    }
}
