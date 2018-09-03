//
//  String.swift
//  PLU-Hash-Calculator
//
//  Created by Pascal Kimmel on 22-10-17.
//  Copyright © 2017 Pascal Kimmel. All rights reserved.
//

import Foundation

extension String {
    enum OffsetType {
        case left, right
    }
    
    func substringWith(numberOfcharacters from: Int, fromThe offset: OffsetType) -> String {
        var newString = String()
        
        switch offset {
        case .left:
            let offset = from < 0 ? from * -1 : from
            let till = index(startIndex, offsetBy: offset)
            newString = String(self[startIndex ..< till])
            
        case .right:
            let offset = from > 0 ? from * -1 : from
            let start = index(endIndex, offsetBy: offset)
            newString = String(self[start ..< endIndex])
        }
        
        return newString
    }
    
    func replaceCharacter(target: String, withString: String) -> String {
        return self.replacingOccurrences(of: target, with: withString, options: NSString.CompareOptions.literal, range: nil)
    }
}
