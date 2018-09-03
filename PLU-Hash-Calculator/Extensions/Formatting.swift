//
//  Formatting.swift
//  PLU-Hash-Calculator
//
//  Created by Pascal Kimmel on 24-10-17.
//  Copyright © 2017 Pascal Kimmel. All rights reserved.
//

import Foundation

extension String {
    var floatValue: Float {
        let nf = NumberFormatter()
        nf.decimalSeparator = "."
        
        if let result = nf.number(from: self) {
            
            return result.floatValue
            
        } else {
            
            nf.decimalSeparator = ","
            if let result = nf.number(from: self) {
                return result.floatValue
            }
        }
        
        return 0
    }

    func decimalPrice() -> String {
        let amount = self.floatValue
        return NSString(format:"%.2f", amount) as String
    }
    
    func decimalQuantity() -> String {
        let amount = self.floatValue
        return String(format: amount == floor(amount) ? "%.0f" : "%.3f", amount)
    }
}
