//
//  PluHashesViewController.swift
//  PLU-Hash-Calculator
//
//  Created by Pascal Kimmel on 22-10-17.
//  Copyright © 2017 Pascal Kimmel. All rights reserved.
//

import UIKit

protocol TableViewRemovalDelegate: class {
    func itemWasRemovedFromDataSource()
}

class PluHashesViewController: UIViewController, Stateful {
    @IBOutlet fileprivate weak var tableView: UITableView!
    
    var pluHashesDataSource: PluHashesDataSource!
    var stateController: StateController!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.delegate = self
        tableView.tableFooterView = UIView()
        
        if let cachedPluHashes = stateController?.pluHashes {
            updateDataSource(withPluHashes: cachedPluHashes)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if isEditing {
            setEditing(false, animated: true)
        }
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        
        tableView.setEditing(editing, animated: animated)
        if editing == false {
            checkIfDataSourceIsEmpty()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let itemsViewController = segue.destination as? ItemsViewController, let indexPath = tableView.indexPathForSelectedRow {
            itemsViewController.pluHash = pluHashesDataSource.pluHash(at: indexPath)
        }
    }
}

private extension PluHashesViewController {
    func updateDataSource(withPluHashes pluHashes: [PluHash]) {
        pluHashesDataSource = PluHashesDataSource(pluHashes: pluHashes)
        pluHashesDataSource.delegate = self
        tableView.dataSource = pluHashesDataSource
        checkIfDataSourceIsEmpty()
        tableView.reloadData()
    }
    
    func checkIfDataSourceIsEmpty() {
        if pluHashesDataSource.pluHashes.count > 0 {
            navigationItem.leftBarButtonItem = editButtonItem
        } else {
            navigationItem.leftBarButtonItem = nil
        }
    }
}

extension PluHashesViewController: TableViewRemovalDelegate  {
    func itemWasRemovedFromDataSource() {
        stateController.pluHashes = pluHashesDataSource.pluHashes
        checkIfDataSourceIsEmpty()
    }
}

extension PluHashesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didEndEditingRowAt indexPath: IndexPath?) {
        stateController.pluHashes = pluHashesDataSource.pluHashes
        checkIfDataSourceIsEmpty()
    }
}
