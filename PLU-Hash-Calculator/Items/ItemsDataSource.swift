//
//  ItemsDataSource.swift
//  PLU-Hash-Calculator
//
//  Created by Pascal Kimmel on 22-10-17.
//  Copyright © 2017 Pascal Kimmel. All rights reserved.
//

import UIKit

class ItemsDataSource: NSObject {
    fileprivate(set) var items: [Item]
    weak var delegate: TableViewRemovalDelegate?
    var editingEnabled = true
    
    var pluHashString: String {
        get {
            return items.pluHashString
        }
    }
    
    init(items: [Item]) {
        self.items = items
    }
    
    func add(item: Item) {
        items.append(item)
    }
    
    func item(at indexPath: IndexPath) -> Item {
        return items[indexPath.row]
    }
}

extension ItemsDataSource: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath) as? ItemCell else {
            return ItemCell()
        }
        
        let item = self.item(at: indexPath)
        cell.configureCell(forItem: item)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return editingEnabled
    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to toIndexPath: IndexPath) {
        let itemToMove = items[fromIndexPath.row]
        items.remove(at: fromIndexPath.row)
        items.insert(itemToMove, at: toIndexPath.row)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            items.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath as IndexPath], with: .fade)
            delegate?.itemWasRemovedFromDataSource()
        }
    }
}
