//
//  BasePresenter.swift
//  Hackaton
//
//  Created by Robson Fernandes on 17/03/18.
//  Copyright © 2018 Robson Fernandes. All rights reserved.
//

import Foundation
import RxSwift

class BasePresenter<T>: BasePresenterContract {
    
    lazy var disposeBag = DisposeBag()
    lazy var unauthAPI = UnauthenticateAPI()
    lazy var authAPI = AuthenticateAPI()

    let view: T
    
    init(view: T) {
        self.view = view
        start()
    }
    
    func start() {
        
    }
}
