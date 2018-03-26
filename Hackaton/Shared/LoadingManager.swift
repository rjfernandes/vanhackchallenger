//
//  LoadingManager.swift
//  Hackaton
//
//  Created by Robson Fernandes on 23/03/18.
//  Copyright © 2018 Robson Fernandes. All rights reserved.
//

import UIKit
import RxSwift

class LoadingManager {
    
    private lazy var disposeBag = DisposeBag()
    
    private let view: UIView
    private let indicatorColor: UIColor
    
    private lazy var loadingActivityView: UIActivityIndicatorView = {
        let loadingActivityView = UIActivityIndicatorView(activityIndicatorStyle: .white)
        loadingActivityView.hidesWhenStopped = true
        return loadingActivityView
    }()
    
    init(at view: UIView, indicatorColor: UIColor? = nil) {
        self.view = view
        self.indicatorColor = indicatorColor ?? view.backgroundColor ?? .red
    }
    
    func toggle(isVisible: Bool) {
        if loadingActivityView.tag == 0 {
            loadingActivityView.tag = 1
            loadingActivityView.color = indicatorColor
            view.superview?.addSubview(loadingActivityView)
            loadingActivityView.center = view.center
        }
        
        loadingActivityView.isHidden = !isVisible
        view.isHidden = isVisible
        isVisible ? loadingActivityView.startAnimating() : loadingActivityView.stopAnimating()
    }
    
    func set(observer: Observable<Bool>) {
        observer.subscribe(onNext: { value in
            self.toggle(isVisible: value)
        }).disposed(by: disposeBag)
    }
}
