//
//  Util.swift
//  Hackaton
//
//  Created by Robson Fernandes on 17/03/18.
//  Copyright © 2018 Robson Fernandes. All rights reserved.
//

import UIKit

func isIphoneX() -> Bool {
    return UIDevice().userInterfaceIdiom == .phone && UIScreen.main.nativeBounds.height == 2436
}
