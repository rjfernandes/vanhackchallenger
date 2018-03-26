//
//  HackatonNavigationController.swift
//  Hackaton
//
//  Created by Robson Fernandes on 23/03/18.
//  Copyright © 2018 Robson Fernandes. All rights reserved.
//

import UIKit

class HackatonNavigationController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationBar.shadowImage = UIImage()
        navigationBar.isTranslucent = false
        let navigationBarAppearace = UINavigationBar.appearance()
        navigationBarAppearace.tintColor = .white
        navigationBarAppearace.barTintColor = .primary
        navigationBarAppearace.titleTextAttributes = [ NSAttributedStringKey.foregroundColor: UIColor.white ]
    }
    
}
