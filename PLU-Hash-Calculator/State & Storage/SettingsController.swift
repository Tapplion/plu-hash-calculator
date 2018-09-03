//
//  SettingsController.swift
//  PLU-Hash-Calculator
//
//  Created by Pascal Kimmel on 29-05-18.
//  Copyright © 2018 Pascal Kimmel. All rights reserved.
//

import Foundation

class SettingsController {
    enum Keys: String {
        case currentScheme
    }
    
    fileprivate let defaults = UserDefaults.standard
    
    var scheme: ColorScheme {
        get {
            let scheme = defaults.object(forKey: Keys.currentScheme.rawValue) as! Serialization
            return ColorScheme(serialization: scheme)
        }
        set {
            defaults.set(newValue.serialization, forKey: Keys.currentScheme.rawValue)
        }
    }
    
    init() {
        defaults.register(defaults: [Keys.currentScheme.rawValue: ColorScheme.defaultScheme.serialization])
    }
}
