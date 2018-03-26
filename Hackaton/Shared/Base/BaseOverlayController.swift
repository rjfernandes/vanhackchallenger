//
//  BaseOverlayController.swift
//  Hackaton
//
//  Created by Robson Fernandes on 17/03/18.
//  Copyright © 2018 Robson Fernandes. All rights reserved.
//

import UIKit
import Material
import RxSwift

protocol OverlayProtocol {
    var overlayController: OverlayController? { get set }
}

class OverlayController: FABMenuController {
    
    private lazy var tabBar = TabBar()
    private var buttons = [TabItem]()
    private var pickedVariable = Variable(0)
    
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
    
    func addTab<T>(items: [T], titleFor: (T) -> String) -> Observable<(index: Int, item: T)> {
        return addTab(items: items.map({ titleFor($0) })).map({ index in (index, items[index]) })
    }
    
    func addTab(items: [String]) -> Observable<Int> {
        items.forEach({ self.addTabButton(title: $0) })
        setupTabbar()
        return pickedVariable.asObservable()
    }
    
    private func addTabButton(title: String) {
        let btn = TabItem(title: title, titleColor: .white)
        btn.titleLabel?.font = .systemFont(ofSize: 14)
        btn.pulseAnimation = .none
        btn.tag = buttons.count
        buttons.append(btn)
    }
    
    private func setupTabbar() {
        tabBar.delegate = self
        
        tabBar.dividerColor = Color.grey.lighten2
        tabBar.dividerAlignment = .bottom
        
        tabBar.backgroundColor = .primary
        tabBar.lineColor = .white
        tabBar.lineAlignment = .bottom
        tabBar.lineHeight = 1
        var edges = tabBar.contentEdgeInsets
        edges.bottom = 2
        tabBar.contentEdgeInsets = edges
        
        tabBar.tabItems = buttons
        
        view.layout(tabBar).horizontally().top()
    }
}

extension OverlayController: TabBarDelegate {
    @objc func tabBar(tabBar: TabBar, willSelect tabItem: TabItem) {
        pickedVariable.value = tabItem.tag
    }
}
