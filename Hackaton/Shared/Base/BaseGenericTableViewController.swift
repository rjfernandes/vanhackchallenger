//
//  BaseGenericTableViewController.swift
//  Hackaton
//
//  Created by Robson Fernandes on 17/03/18.
//  Copyright © 2018 Robson Fernandes. All rights reserved.
//

import UIKit

class BaseGenericTableViewController<T>: BaseTableViewController {
    
    var isDisableReloadDataForNow = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
    }
    
    private var _filter: ((T) -> Bool)?
    
    var items = [T]() {
        didSet {
            putFilter()
        }
    }
    
    func clearFilter() {
        _filter = nil
        putFilter()
    }
    
    func filter(_ filterToApply: @escaping (T) -> Bool) {
        _filter = filterToApply
        putFilter()
    }
    
    private func putFilter() {
        filteredItems.removeAll()
        if let filter = _filter {
            filteredItems += items.filter(filter)
        }
        else {
            filteredItems += items
        }

        if isDisableReloadDataForNow {
            isDisableReloadDataForNow = false
            return
        }
        
        tableView.reloadData()
    }
    
    var filteredItems = [T]()
    
    func identifier(at indexPath: IndexPath) -> String {
        return "cell"
    }
    
    func custom(cell: UITableViewCell, with item: T, at indexPath: IndexPath) {
        custom(cell: cell, with: item)
    }
    
    func custom(cell: UITableViewCell, with item: T) {
        
    }
    
    func picked(item: T, at indexPath: IndexPath) {
        picked(item: item)
    }
    
    func picked(item: T) {
        
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredItems.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier(at: indexPath), for: indexPath)
        custom(cell: cell, with: filteredItems[indexPath.row], at: indexPath)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        picked(item: filteredItems[indexPath.row], at: indexPath)
    }
    
}

