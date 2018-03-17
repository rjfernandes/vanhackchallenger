//
//  ProductController.swift
//  Hackaton
//
//  Created by Robson Fernandes on 17/03/18.
//  Copyright © 2018 Robson Fernandes. All rights reserved.
//

import UIKit
import Material

class ProductController: BaseGenericTableViewController<ProductResponseModel>, OverlayProtocol {
    
    //MARK: Outlets
    @IBOutlet var cartView: UIView!
    @IBOutlet var amountProductsLabel: UILabel!
    @IBOutlet var totalCart: UILabel!
    
    var store: StoreItem!
    
    var overlayController: OverlayController?
    
    lazy var presenter = ProductPresenter(view: self)
    lazy var btnOrders = UIBarButtonItem(title: "Orders", style: .plain, target: self, action: #selector(gotoOrdersTap))
    
    var cart = [ProductResponseModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.set(store: store)
        presenter.request()
        btnOrders = UIBarButtonItem(title: "Orders", style: .plain, target: self, action: #selector(gotoOrdersTap))
        overlayController?.navigationItem.rightBarButtonItem = btnOrders
    }
    
    @objc func gotoOrdersTap() {
        push(controllerType: .orders)
    }
    
    override func custom(cell: UITableViewCell, with item: ProductResponseModel) {
        if let cell = cell as? ProductCell {
            cell.product = item
            cell.accessoryType = cart.contains(item) ? .checkmark : .none
        }
    }
    
    override func picked(item: ProductResponseModel, at indexPath: IndexPath) {
        if let index = cart.index(of: item) {
            cart.remove(at: index)
        }
        else {
            cart += [ item ]
        }
        
        toggleCart()
        
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
    
    //MARK: - Cart
    
    func toggleCart() {
        if cartView.tag == 0 {
            cartView.tag = 1
            overlayController?
                .view.layout(cartView)
                .height(isIphoneX() ? 64 : 44 )
                .horizontally()
                .bottom()
        }
        
        amountProductsLabel.text = "\(cart.count) product(s) on cart"
        totalCart.text = cart.map({ $0.price }).reduce(0.0, +).currency
        cartView.isHidden = cart.isEmpty
    }

    @IBAction func placeOrderTap() {
        presenter.createOrder(cart: cart)
    }
}

extension ProductController: ProductViewContract {
    
    func backToStores() {
        alert(message: "Order created sucessfully") {
            self.overlayController?.navigationController?.popViewController(animated: true)
        }
    }
    
    func showLoading() { }
    
    func hideLoading() { }
    
    func show(error: String) {
        alert(message: error)
    }
    
    func populate(products: [ProductResponseModel]) {
        self.items += products
    }
}
