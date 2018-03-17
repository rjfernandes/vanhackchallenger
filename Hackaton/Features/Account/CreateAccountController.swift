//
//  CreateAccountController.swift
//  Hackaton
//
//  Created by Robson Fernandes on 17/03/18.
//  Copyright © 2018 Robson Fernandes. All rights reserved.
//

import UIKit

class AccountController: BaseTableViewController {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var repeatPasswordTextField: UITextField!
    
    lazy var presenter = AccountPresenter(view: self)
    
    @IBAction func saveTap() {
        presenter.store(name: nameTextField.text, email: emailTextField.text, address: addressTextField.text, password: passwordTextField.text, repeatPassword: repeatPasswordTextField.text)
    }
    
}

extension AccountController: AccountViewContract {
    func show(error: String) {
        alert(message: error)
    }
    
    func showLoading() {
        
    }
    
    func hideLoading() {
        
    }
    
    func success() {
        navigationController?.popToRootViewController(animated: true)
    }
}
