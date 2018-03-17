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
    @IBOutlet weak var requestingActivityIndicatorView: UIActivityIndicatorView!
    
    var orders = [OrderItem]()
    lazy var presenter = AddressPresenter(view: self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupActivityIndicator()
        presenter.set(pickedOrders: orders)
    }
    
    func setupActivityIndicator() {
        requestingActivityIndicatorView.hidesWhenStopped = true
        requestingActivityIndicatorView.isHidden = true
    }
    
    //MARK: Action
    
    @IBAction func placeOrdersTap() {
        presenter.placeOrders(contactName: contactNameTextField.text, deliveryAddress: deliveryAddressTextView.text)
    }
}

extension AddressController: AddressViewContract {
    
    func show(error: String) {
        alert(message: error)
    }
    
    func success() {
        alert(message: "Orders placed sucessfully")
    }
    
    func showLoading() {
        requestingActivityIndicatorView.isHidden = false
        requestingActivityIndicatorView.startAnimating()
        placeOrdersButton.isHidden = true
    }
    
    func hideLoading() {
        requestingActivityIndicatorView.stopAnimating()
        placeOrdersButton.isHidden = false
    }
}
