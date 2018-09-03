//
//  AddItemViewController.swift
//  PLU-Hash-Calculator
//
//  Created by Pascal Kimmel on 24-10-17.
//  Copyright © 2017 Pascal Kimmel. All rights reserved.
//

import UIKit

protocol NewItemAddedDelegate: class {
    func newlyAdded(item: Item)
}

class AddItemViewController: UIViewController {
    @IBOutlet fileprivate weak var quantityTextField: UITextField!
    @IBOutlet fileprivate weak var nameTextField: UITextField!
    @IBOutlet fileprivate weak var priceTextField: UITextField!
    @IBOutlet fileprivate weak var vatSignTextField: UITextField!
    
    weak var delegate: NewItemAddedDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "SaveSegue" else {
            return
        }
        
        guard let quantity = quantityTextField.text, let name = nameTextField.text, let price = priceTextField.text, let vatSign = vatSignTextField.text else {
            return
        }
        delegate?.newlyAdded(item: Item(quantity: quantity, name: name, price: price, vatSign: vatSign))
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        guard identifier == "SaveSegue" else {
            return true
        }
        
        guard quantityTextField.text != "" else {
            presentAlertController(withTitle: "Missing quantity", message: "Quantity is required when addding an item.")
            return false
        }
        
        guard nameTextField.text != "" else {
            presentAlertController(withTitle: "Missing name", message: "Name is required when addding an item.")
            return false
        }
        
        guard priceTextField.text != "" else {
            presentAlertController(withTitle: "Missing price", message: "Price is required when addding an item.")
            return false
        }
        
        guard vatSignTextField.text != "" else {
            presentAlertController(withTitle: "Missing Vat Sign", message: "Vat Sign is required when addding an item.")
            return false
        }
        return true
    }
}

extension AddItemViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
