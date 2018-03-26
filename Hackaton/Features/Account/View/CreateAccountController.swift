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
    @IBOutlet weak var saveButton: UIButton!
    
    lazy var presenter = AccountPresenter(view: self)
    lazy var loadingManager = LoadingManager(at: saveButton)
    
    @IBAction func saveTap() {
        view.endEditing(true)
        presenter.store(name: nameTextField.text, email: emailTextField.text, address: addressTextField.text, password: passwordTextField.text, repeatPassword: repeatPasswordTextField.text)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        [nameTextField, emailTextField, addressTextField, passwordTextField, repeatPasswordTextField].forEach { $0?.setPaddingLeft() }
        loadingManager.set(observer: presenter.unauthAPI.requestingObserver)
    }
}

extension AccountController: AccountViewContract {
    func show(error: String) {
        alert(message: error)
    }

    func success() {
        navigationController?.popToRootViewController(animated: true)
    }
}
