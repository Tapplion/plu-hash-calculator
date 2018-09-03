//
//  PluHash.swift
//  PLU-Hash-Calculator
//
//  Created by Pascal Kimmel on 22-10-17.
//  Copyright © 2017 Pascal Kimmel. All rights reserved.
//

import Foundation

struct PluHash {
    let id: String
    let value: String
    let reference: String
    let items: [Item]
}

extension PluHash {
    enum Keys: String, SerializationKey {
        case id, value, reference, items
    }
    
    init(serialization: Serialization) {
        id = serialization.value(forKey: Keys.id)!
        value = serialization.value(forKey: Keys.value)!
        reference = serialization.value(forKey: Keys.reference)!
        let serializedItems: [Serialization] = serialization.value(forKey: Keys.items)!
        items = serializedItems.map(Item.init)
    }
    
    var serialization: Serialization {
        var serialization: Serialization = [:]
        serialization.set(value: id, forKey: Keys.id)
        serialization.set(value: value, forKey: Keys.value)
        serialization.set(value: reference, forKey: Keys.reference)
        serialization.set(value: items.map{$0.serialization}, forKey: Keys.items)
        return serialization
    }
}
