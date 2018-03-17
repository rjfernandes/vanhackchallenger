//
//  BaseOverlayController.swift
//  Hackaton
//
//  Created by Robson Fernandes on 17/03/18.
//  Copyright © 2018 Robson Fernandes. All rights reserved.
//

import UIKit
import Material

protocol OverlayProtocol {
    var overlayController: OverlayController? { get set }
}

class OverlayController: FABMenuController {
    
    override init(rootViewController: UIViewController) {
        super.init(rootViewController: rootViewController)
        if var vc = rootViewController as? OverlayProtocol {
            vc.overlayController = self
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = rootViewController.title
    }
    
}
