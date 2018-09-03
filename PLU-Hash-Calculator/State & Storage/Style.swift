//
//  Style.swift
//  PLU-Hash-Calculator
//
//  Created by Pascal Kimmel on 29-05-18.
//  Copyright © 2018 Pascal Kimmel. All rights reserved.
//

import UIKit

extension UIColor {
    enum Keys: String, SerializationKey {
        case red
        case green
        case blue
        case alpha
    }
    
    var serialization: Serialization {
        var red: CGFloat = 0.0
        var green: CGFloat = 0.0
        var blue: CGFloat = 0.0
        var alpha: CGFloat = 0.0
        getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        var serialization: Serialization = [:]
        serialization.set(value: red, forKey: Keys.red)
        serialization.set(value: green, forKey: Keys.green)
        serialization.set(value: blue, forKey: Keys.blue)
        serialization.set(value: alpha, forKey: Keys.alpha)
        return serialization
    }
    
    convenience init(serialization: Serialization) {
        self.init(red: serialization.value(forKey: Keys.red)!,
                  green: serialization.value(forKey: Keys.green)!,
                  blue: serialization.value(forKey: Keys.blue)!,
                  alpha: serialization.value(forKey: Keys.alpha)!)
    }
    
    static let navBarColor = UIColor(red: 37/255, green: 37/255, blue: 37/255, alpha: 1.0)
    
}

struct ColorScheme {
    let name: String
    let titlesColor: UIColor
    let buttonsColor: UIColor
    let navBarColor: UIColor
}

extension ColorScheme {
    enum Keys: String, SerializationKey {
        case name
        case titlesColor
        case buttonsColor
        case navBarColor
    }
    
    var serialization: Serialization {
        var serialization: Serialization = [:]
        serialization.set(value: name, forKey: Keys.name)
        serialization.set(value: titlesColor.serialization, forKey: Keys.titlesColor)
        serialization.set(value: buttonsColor.serialization, forKey: Keys.buttonsColor)
        serialization.set(value: navBarColor.serialization, forKey: Keys.navBarColor)
        return serialization
    }
    
    init(serialization: Serialization) {
        name = serialization.value(forKey: Keys.name)!
        titlesColor = UIColor(serialization: serialization.value(forKey: Keys.titlesColor)!)
        buttonsColor = UIColor(serialization: serialization.value(forKey: Keys.buttonsColor)!)
        navBarColor = UIColor(serialization: serialization.value(forKey: Keys.navBarColor)!)
    }
}

extension ColorScheme {
    static let defaultScheme = ColorScheme(name: "default", titlesColor: .white, buttonsColor: .navBarColor, navBarColor: .navBarColor)
}
