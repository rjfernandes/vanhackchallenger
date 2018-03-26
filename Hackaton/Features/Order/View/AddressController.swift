//
//  AddressController.swift
//  Hackaton
//
//  Created by Robson Fernandes on 17/03/18.
//  Copyright © 2018 Robson Fernandes. All rights reserved.
//

import UIKit

class AddressController: BaseTableViewController {
    
    @IBOutlet weak var contactNameTextField: UITextField!
    @IBOutlet weak var deliveryAddressTextView: UITextView!
    @IBOutlet weak var placeOrdersButton: UIButton!
    
    var orders = [StoreOrder]()
    lazy var presenter = AddressPresenter(view: self)
    lazy var loadingManager = LoadingManager(at: placeOrdersButton)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.set(pickedOrders: orders)
        loadingManager.set(observer: presenter.orderAPI.requestingObserver)
        setupView()
    }
    
    func setupView() {
        [contactNameTextField, deliveryAddressTextView].forEach({ item in
            (item as? UIView)?.layer.borderWidth = 0.5
            (item as? UIView)?.layer.borderColor = UIColor.lightGray.cgColor
        })
        contactNameTextField.setPaddingLeft()
    }
    
    //MARK: Action
    
    @IBAction func placeOrdersTap() {
        view.endEditing(true)
        presenter.placeOrders(contactName: contactNameTextField.text, deliveryAddress: deliveryAddressTextView.text)
    }
}

extension AddressController: AddressViewContract {
    func set(contactName: String?) {
        contactNameTextField.text = contactName
    }
    
    func show(error: String) {
        alert(message: error)
    }
    
    func success() {
        alert(message: "Orders placed sucessfully")
    }
}
