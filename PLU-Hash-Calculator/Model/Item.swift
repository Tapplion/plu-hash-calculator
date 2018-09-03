//
//  Item.swift
//  PLU-Hash-Calculator
//
//  Created by Pascal Kimmel on 22-10-17.
//  Copyright © 2017 Pascal Kimmel. All rights reserved.
//

import Foundation

struct Item {
    let quantity: String
    let name: String
    let price: String
    let vatSign: String
}

extension Item {
    enum Keys: String, SerializationKey {
        case quantity, name, price, vatSign
    }
    
    init(serialization: Serialization) {
        quantity = serialization.value(forKey: Keys.quantity)!
        name = serialization.value(forKey: Keys.name)!
        price = serialization.value(forKey: Keys.price)!
        vatSign = serialization.value(forKey: Keys.vatSign)!
    }
    
    var serialization: Serialization {
        var serialization: Serialization = [:]
        serialization.set(value: quantity, forKey: Keys.quantity)
        serialization.set(value: name, forKey: Keys.name)
        serialization.set(value: price, forKey: Keys.price)
        serialization.set(value: vatSign, forKey: Keys.vatSign)
        return serialization
    }
}

extension Array where Element == Item {
    var pluHashString: String {
        get {
            return generatePluHash(for: self)
        }
    }

    private func generatePluHash(for items: [Item]) -> String {
        var pluString = ""
        
        let itemFormatter = NumberFormatter()
        itemFormatter.minimumIntegerDigits = 4
        itemFormatter.maximumIntegerDigits = 4
        
        let priceFormatter = NumberFormatter()
        priceFormatter.minimumIntegerDigits = 8
        priceFormatter.maximumIntegerDigits = 8
        
        for item in items {
            
            var qtyStr = ""

            if item.quantity.floatValue.isInt {
                qtyStr = itemFormatter.string(from: NSNumber(value: Int(item.quantity.floatValue)))!
            } else {
                qtyStr = itemFormatter.string(from: NSNumber(value: item.quantity.floatValue * 1000))!
            }
            
            qtyStr = qtyStr.replaceCharacter(target: "-", withString: "")
                .folding(options: .diacriticInsensitive, locale: nil).padding(toLength: 4, withPad: "0", startingAt: 0)
            
            let nameStr = item.name.updatedName().folding(options: .diacriticInsensitive, locale: nil).padding(toLength: 20, withPad: " ", startingAt: 0)
            let priceStr = priceFormatter.string(from: NSNumber(value: item.price.floatValue * 100))!.replaceCharacter(target: "-", withString: "")
            let vatStr = item.vatSign.uppercased()
            
            let plu = qtyStr + nameStr + priceStr + vatStr
            
            pluString += plu
        }
        
        return pluString.sha1Value
    }
}

private extension String {
    func updatedName() -> String {
        let allowedChars = Set("abcdefghijklmnopqrstuvwxyz ABCDEFGHIJKLKMNOPQRSTUVWXYZ1234567890 ÄÅÂÁÀâäáàã Æ æ ß çÇ ÎÏÍÌïîìí € ÊËÉÈêëéè ÛÜÚÙüûúù ÔÖÓÒöôóò ñÑ ýÝÿ")
        return String(self.filter {allowedChars.contains($0) })
            .replaceCharacter(target: " ", withString: "")
            .replaceCharacter(target: "€", withString: "e")
            .uppercased()
    }
    
    var sha1Value: String {
        get {
            let data = self.data(using: String.Encoding.utf8)!
            var digest = [UInt8](repeating: 0, count:Int(CC_SHA1_DIGEST_LENGTH))
            data.withUnsafeBytes {
                _ = CC_SHA1($0, CC_LONG(data.count), &digest)
            }
            let hexBytes = digest.map { String(format: "%02hhx", $0) }
            return hexBytes.joined(separator: "")
        }
    }
}
