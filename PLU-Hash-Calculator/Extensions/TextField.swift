//
//  TextField.swift
//  PLU-Hash-Calculator
//
//  Created by Pascal Kimmel on 24-10-17.
//  Copyright © 2017 Pascal Kimmel. All rights reserved.
//

import UIKit

private var maxLengths = [UITextField: Int]()

extension UITextField {
    
    @IBInspectable var maxLength: Int {
        get {
            guard let length = maxLengths[self] else {
                return Int.max
            }
            return length
        }
        set {
            maxLengths[self] = newValue
            addTarget(self, action: #selector(limitLength), for: UIControl.Event.editingChanged)
        }
    }
    
    @objc func limitLength(textField: UITextField) {
        guard let prospectiveText = textField.text, prospectiveText.count > maxLength else {
            return
        }
                
        let selection = selectedTextRange
        let maxCharIndex = prospectiveText.index(prospectiveText.startIndex, offsetBy: maxLength)
        text = String(describing: prospectiveText.prefix(upTo: maxCharIndex))
        selectedTextRange = selection
    }
    
    override open func awakeFromNib() {
        layer.borderWidth = 0.0
    }
    
    //For placeholder
    func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 5, dy: 0)
    }
    
    //For editable text
    func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 5, dy: 0)
    }    
}
