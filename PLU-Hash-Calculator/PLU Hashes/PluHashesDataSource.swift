//
//  PluHashesDataSource.swift
//  PLU-Hash-Calculator
//
//  Created by Pascal Kimmel on 22-10-17.
//  Copyright © 2017 Pascal Kimmel. All rights reserved.
//

import UIKit

class PluHashesDataSource: NSObject {
    fileprivate(set) var pluHashes: [PluHash]
    weak var delegate: TableViewRemovalDelegate?
    
    init(pluHashes: [PluHash]) {
        self.pluHashes = pluHashes
    }
    
    func pluHash(at indexPath: IndexPath) -> PluHash {
        return pluHashes[indexPath.row]
    }
}

extension PluHashesDataSource: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pluHashes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PluHashCell", for: indexPath) as? PluHashCell else {
            return PluHashCell()
        }
        
        let pluHash = self.pluHash(at: indexPath)
        cell.value = pluHash.value
        cell.reference = pluHash.reference
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            pluHashes.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath as IndexPath], with: .fade)
            delegate?.itemWasRemovedFromDataSource()
        }
    }
}
