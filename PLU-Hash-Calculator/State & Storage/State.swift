//
//  State.swift
//  PLU-Hash-Calculator
//
//  Created by Pascal Kimmel on 22-10-17.
//  Copyright © 2017 Pascal Kimmel. All rights reserved.
//

import Foundation

class State {
    
    let storageController = StorageController()
    let settingsController = SettingsController()
    let stateController: StateController
    
    init() {
        stateController = StateController(storageController: storageController)
    }
    
}

protocol Stateful: class {
    var stateController: StateController! { get set }
}

protocol SettingsConfigurable: class {
    var settingsController: SettingsController! { get set }
}
