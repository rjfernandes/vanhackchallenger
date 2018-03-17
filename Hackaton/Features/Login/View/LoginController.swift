//
//  LoginController.swift
//  Hackaton
//
//  Created by Robson Fernandes on 17/03/18.
//  Copyright © 2018 Robson Fernandes. All rights reserved.
//

import UIKit

class LoginController: BaseTableViewController {
    
    // Presenter
    lazy var presenter = LoginPresenter(view: self)
    lazy var checkUserLoggedService = CheckUserLoggedService()
    
    // Outlets
    @IBOutlet weak var emailTextView: UITextField!
    @IBOutlet weak var passwordTextView: UITextField!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if checkUserLoggedService.isLogged() {
            granteed()
        }
    }
    
    // Actions
    
    @IBAction func loginTap() {
        presenter.login(email: emailTextView.text, password: passwordTextView.text)
    }
    
    @IBAction func createAccountTap() {
        push(controllerType: .createAccount)
    }
}

extension LoginController: LoginViewContract {
    func showLoading() {
        
    }
    
    func hideLoading() {
        
    }
    
    func show(error: String) {
        alert(message: error)
    }
    
    func granteed() {
        if let controller = create(controllerType: .stores) {
            let navController = UINavigationController(rootViewController: controller)
            present(navController, animated: true, completion: nil)
        }
    }
    
    func gotoCreateAccount() {
        push(controllerType: .createAccount)
    }
}
