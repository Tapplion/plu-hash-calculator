//
//  ItemTextField.swift
//  PLU-Hash-Calculator
//
//  Created by Pascal Kimmel on 24-10-17.
//  Copyright © 2017 Pascal Kimmel. All rights reserved.
//

import UIKit

fileprivate var maxLengths = [UITextField: Int]()

class ItemTextField: UITextField, UITextFieldDelegate {
    @IBInspectable var allowedChars: String = ""
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        delegate = self
        autocorrectionType = .no
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return string.containsOnlyCharactersIn(matchCharacters: allowedChars)
    }
}

private extension String {
    func containsOnlyCharactersIn(matchCharacters: String) -> Bool {
        let disallowedCharacterSet = NSCharacterSet(charactersIn: matchCharacters).inverted
        return self.rangeOfCharacter(from: disallowedCharacterSet) == nil
    }
}
