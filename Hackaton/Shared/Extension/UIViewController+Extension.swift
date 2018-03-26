//
//  UIViewController+Extension.swift
//  Hackaton
//
//  Created by Robson Fernandes on 17/03/18.
//  Copyright © 2018 Robson Fernandes. All rights reserved.
//

import UIKit
import FontAwesome_swift

extension UIViewController {
    
    func addBackButton() {
        guard navigationController?.viewControllers.count ?? 0 > 1 else { return }
        let image = UIImage.fontAwesomeIcon(name: .chevronLeft, textColor: .white, size: CGSize(width: 24, height: 24))
        let button = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(goBack))
        ((self as? OverlayProtocol)?.overlayController ?? self).navigationItem.leftBarButtonItem = button
    }
    
    @objc func goBack() {
        navigationController?.popViewController(animated: true)
    }
    
    func alert(message: String, completion: (() -> Void)? = nil) {
        confirm(message: message, yesButtonTitle: "OK", noButtonTitle: nil) { _ in
            completion?()
        }
    }
    
    func create<T: UIViewController>(controllerType: ControllerType) -> T? {
        return UIStoryboard(name: controllerType.rawValue, bundle: nil).instantiateInitialViewController() as? T
    }
    
    func push<T: UIViewController>(controllerType: ControllerType, hasOverlay: Bool = false, isModal: Bool = false, isAnimated: Bool = true, prepare: ((T) -> Void)? = nil) {
        if let controller = create(controllerType: controllerType) as? T {
            prepare?(controller)
            
            let viewController = hasOverlay ? OverlayController(rootViewController: controller) : controller
            let mainController = (self as? OverlayProtocol)?.overlayController ?? self
            
            if isModal {
                mainController.present(viewController, animated: isAnimated, completion: nil)
            }
            else {
                mainController.navigationController?.pushViewController(viewController, animated: isAnimated)
            }
        }
    }

    
    func confirm(message: String, yesButtonTitle: String = "Yes", noButtonTitle: String? = "No", style: UIAlertControllerStyle = .alert,  completion: ((Bool) -> Void)? = nil) {

        let alertViewController = UIAlertController(title: AppConfig.appTitle, message: message, preferredStyle: style)
        
        let yesButtonAction = UIAlertAction(title: yesButtonTitle, style: .default) { _ in
            completion?(true)
        }
        alertViewController.addAction(yesButtonAction)
        
        if let noButtonTitle = noButtonTitle {
            let noButtonAction = UIAlertAction(title: noButtonTitle, style: .cancel, handler: { _ in
                completion?(false)
            })
            alertViewController.addAction(noButtonAction)
        }
        
        present(alertViewController, animated: true, completion: nil)
        
    }
}
