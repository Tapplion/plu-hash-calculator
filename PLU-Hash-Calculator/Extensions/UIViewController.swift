//
//  UIViewController.swift
//  PLU-Hash-Calculator
//
//  Created by Pascal Kimmel on 24-10-17.
//  Copyright © 2017 Pascal Kimmel. All rights reserved.
//

import UIKit

extension UIViewController {
    typealias alertHandler = ((UIAlertAction?) -> Void)
    
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
        tap.cancelsTouchesInView = false
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    var currentDate: String {
        get {
            let currentDate = NSDate()
            let dateFormatter = DateFormatter()
            var convertedDate = dateFormatter.string(from: currentDate as Date)
            dateFormatter.dateFormat = "dd-MM-yyyy HH:mm:ss"
            convertedDate = dateFormatter.string(from: currentDate as Date)
            
            return convertedDate
        }
    }
    
    func presentAlertController(withTitle title: String, message: String) {
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
    }
    
    func presentAlertControllerWithTextField(andTitle title: String, message: String, confirmTitle: String, cancelTitle: String, placeHolder: String, confirmHandler: ((_ text: String?) -> Void)? = nil, cancelHandler: alertHandler?) {
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let confirmAction = UIAlertAction(title: confirmTitle, style: .cancel, handler: { action in
            guard let text = alertController.textFields?.first?.text else {
                confirmHandler?(nil)
                return
            }
            confirmHandler?(text)
        })
        let cancelAction = UIAlertAction(title: cancelTitle, style: .destructive, handler: cancelHandler)
        
        alertController.addTextField { (textField) in
            textField.placeholder = placeHolder
        }
        alertController.addAction(cancelAction)
        alertController.addAction(confirmAction)
        present(alertController, animated: true, completion: nil)
    }
}
