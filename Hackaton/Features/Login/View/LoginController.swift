//
//  LoginController.swift
//  Hackaton
//
//  Created by Robson Fernandes on 17/03/18.
//  Copyright © 2018 Robson Fernandes. All rights reserved.
//

import UIKit

class LoginController: BaseTableViewController {
    
    // Outlets
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    // Presenter
    lazy var presenter = LoginPresenter(view: self)
    lazy var checkUserLoggedService = CheckUserLoggedService()
    lazy var loadingManager = LoadingManager(at: loginButton)
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
        loadingManager.set(observer: presenter.loginAPI.requestingObserver)
        [emailTextField, passwordTextField].forEach { $0?.setPaddingLeft() }
        if checkUserLoggedService.isLogged() {
            granteed()
        }
    }
    
    // Actions
    
    @IBAction func loginTap() {
        view.endEditing(true)
        presenter.login(email: emailTextField.text, password: passwordTextField.text)
    }
    
    @IBAction func createAccountTap() {
        push(controllerType: .createAccount)
    }
}

extension LoginController: LoginViewContract {
    func show(error: String) {
        alert(message: error)
    }
    
    func granteed() {
        if let controller = create(controllerType: .stores) {
            let overlayController = OverlayController(rootViewController: controller)
            let navController = HackatonNavigationController(rootViewController: overlayController)
            present(navController, animated: true, completion: nil)
        }
    }
    
    func gotoCreateAccount() {
        push(controllerType: .createAccount)
    }
}
