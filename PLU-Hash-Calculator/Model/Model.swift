//
//  Model.swift
//  PLU-Hash-Calculator
//
//  Created by Pascal Kimmel on 13-05-18.
//  Copyright © 2018 Pascal Kimmel. All rights reserved.
//

import UIKit

typealias Serialization = [String: AnyObject]

protocol SerializationValue {}

extension Int: SerializationValue {}
extension String: SerializationValue {}
extension Float: SerializationValue {}
extension Dictionary: SerializationValue {}
extension Array: SerializationValue {}

protocol SerializationKey {
    var stringRepresentation: String { get }
}

extension RawRepresentable where RawValue == String {
    var stringRepresentation: String {
        return rawValue
    }
}

extension Dictionary where Value: AnyObject {
    
    func value<T>(forKey key: SerializationKey) -> T? {
        return self[key.stringRepresentation as! Key] as? T
    }

    mutating func set<T>(value: T?, forKey key: SerializationKey) {
        self[key.stringRepresentation as! Key] = value as? Value
    }
}
