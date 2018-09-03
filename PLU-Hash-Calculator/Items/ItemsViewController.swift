//
//  ItemsViewController.swift
//  PLU-Hash-Calculator
//
//  Created by Pascal Kimmel on 22-10-17.
//  Copyright © 2017 Pascal Kimmel. All rights reserved.
//

import UIKit

class ItemsViewController: UIViewController, Stateful, SettingsConfigurable {
    @IBOutlet fileprivate weak var tableView: UITableView!
    @IBOutlet fileprivate weak var pluHashLabel: UILabel!
    @IBOutlet fileprivate weak var saveButton: UIButton!
    
    var pluHash: PluHash?
    var itemsDataSource: ItemsDataSource!
    var stateController: StateController!
    var settingsController: SettingsController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.layer.borderColor = UIColor(red: 37/255, green: 37/255, blue: 37/255, alpha: 1.0).cgColor
        tableView.layer.borderWidth = 0.3
        tableView.tableFooterView = UIView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        applyStyle()
        updateUI()
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
            updatePluHashString()
        }
    }
    
    @IBAction func addNewItem(_ sender: UIButton) {
        performSegue(withIdentifier: "AddNewItem", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let navigtionController = segue.destination as? UINavigationController, let addItemsViewController = navigtionController.topViewController as? AddItemViewController {
            addItemsViewController.delegate = self
        }
    }
    
    @IBAction func savePluHash(_ sender: UIButton) {
        presentAlertControllerWithTextField(andTitle: "Add Reference?", message: "", confirmTitle: "Save", cancelTitle: "Cancel", placeHolder: "Reference", confirmHandler: { input in
            self.savePluHash(withReference: input)
        }, cancelHandler: nil)
    }
    
    func test(withName name: String?) {
        if let name = name {
            print(name)
        }
    }
    
    @IBAction func newItemWasCanceled(_ segue: UIStoryboardSegue) { }
    @IBAction func newItemWasSaved(_ segue: UIStoryboardSegue) { }
}

private extension ItemsViewController {
    func updateUI() {
        if let pluHash = pluHash {
            navigationItem.rightBarButtonItems = nil
            navigationItem.title = "Items"
            pluHashLabel.text = pluHash.value
            populateTableView(withItems: pluHash.items)
        } else {
            if itemsDataSource == nil {
                let items: [Item] = []
                populateTableView(withItems: items)
            } else {
                tableView.reloadData()
            }
            checkIfDataSourceIsEmpty()
            updatePluHashString()
        }
    }
    
    func populateTableView(withItems items: [Item]) {
        itemsDataSource = ItemsDataSource(items: items)
        itemsDataSource.editingEnabled = pluHash == nil ? true : false
        itemsDataSource.delegate = self
        tableView.dataSource = itemsDataSource
        tableView.reloadData()
    }
    
    func checkIfDataSourceIsEmpty() {
        if itemsDataSource.items.count > 0 {
            navigationItem.leftBarButtonItem = editButtonItem
            pluHashLabel.isHidden = false
            saveButton.isHidden = false
        } else {
            navigationItem.leftBarButtonItem = nil
            pluHashLabel.isHidden = true
            saveButton.isHidden = true
        }
    }
    
    func updatePluHashString() {
        pluHashLabel.text = itemsDataSource.pluHashString
    }
    
    func savePluHash(withReference reference: String?) {
        let ref = reference == "" ? currentDate : reference
        let pluHash = PluHash(id: "", value: itemsDataSource.pluHashString, reference: ref!, items: itemsDataSource.items)
        stateController.add(pluHash)
        populateTableView(withItems: [Item]())
        updateUI()
    }
    
    func applyStyle() {
        saveButton.backgroundColor = settingsController.scheme.navBarColor
        saveButton.setTitleColor(settingsController.scheme.titlesColor, for: .normal)
    }
}

extension ItemsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didEndEditingRowAt indexPath: IndexPath?) {
        updatePluHashString()
        checkIfDataSourceIsEmpty()
    }
}

extension ItemsViewController: NewItemAddedDelegate {
    func newlyAdded(item: Item) {
        itemsDataSource.add(item: item)
    }
}

extension ItemsViewController: TableViewRemovalDelegate {
    func itemWasRemovedFromDataSource() {
        checkIfDataSourceIsEmpty()
    }
}
