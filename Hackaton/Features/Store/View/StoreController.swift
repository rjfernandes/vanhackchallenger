//
//  StoreController.swift
//  Hackaton
//
//  Created by Robson Fernandes on 17/03/18.
//  Copyright © 2018 Robson Fernandes. All rights reserved.
//

import UIKit
import FontAwesome_swift

class StoreController: BaseGenericTableViewController<StoreItem>, OverlayProtocol {
    
    @IBOutlet var placeOrdersView: UIView!
    @IBOutlet var amountOrdersLabel: UILabel!
    @IBOutlet var totalOrdersLabel: UILabel!
    @IBOutlet var placeOrdersButton: UIButton!
    
    var overlayController: OverlayController?
    private let boxHeight: CGFloat = isIphoneX() ? 64 : 44
    
    lazy var presenter = StorePresenter(view: self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.requestCousines()
        setupNavButtons()
        setupOrdersView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        toggleOrders()
    }
    
    func setupNavButtons() {
        let btnLogout = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(logoutTap))
        overlayController?.navigationItem.rightBarButtonItem = btnLogout
        let cartImage = UIImage.fontAwesomeIcon(name: .shoppingCart, textColor: .white, size: CGSize(width: 24, height: 24))
        let btnOrders = UIBarButtonItem(image: cartImage, style: .plain, target: self, action: #selector(ordersTap))
        overlayController?.navigationItem.leftBarButtonItem = btnOrders
    }
    
    func setupOrdersView() {
        placeOrdersButton.layer.cornerRadius = 8
        let cartImage = UIImage.fontAwesomeIcon(name: .shoppingCart, textColor: .primary, size: CGSize(width: 20, height: 20))
        placeOrdersButton.setImage(cartImage, for: .normal)
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
    
    //MARK:- Orders
    
    @IBAction func placeOrder() {
        ordersTap()
    }
    
    func toggleOrders() {
        if placeOrdersView.tag == 0 {
            placeOrdersView.tag = 1
            overlayController?
                .view.layout(placeOrdersView)
                .height(isIphoneX() ? 64 : 44 )
                .horizontally()
                .bottom(boxHeight * -1.0)
        }
        
        amountOrdersLabel.text = "\(orders.count) orders(s)"
        totalOrdersLabel.text = orders.flatMap({ $0.orders }).map({ $0.total }).reduce(0.0, +).currency
        placeOrdersView.animate([ .translate(x: 0, y: boxHeight * (orders.isEmpty ? 1 : -1), z: 0) ])
    }

}

extension StoreController: StoreViewContract {
    func populateTab(cousines: [CousineModel]) {
        tableView.contentInset.top = 48
        overlayController?.addTab(items: cousines, titleFor: { $0.name }).subscribe(onNext: { value in
            self.presenter.requestStoresBy(cousine: value.item)
        }).disposed(by: presenter.disposeBag)
    }
    
    func gotoProducts(store: StoreItem) {
        push(controllerType: .products, hasOverlay: true) { (controller: ProductController) in
            controller.store = store
        }
    }
    
    func populate(items: [StoreItem]) {
        self.items.removeAll()
        self.items += items
    }
    
    func show(error: String) {
        alert(message: error)
    }
    
    func logout() {
        dismiss(animated: true, completion: nil)
    }

}
