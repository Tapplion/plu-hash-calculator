//
//  StateController.swift
//  PLU-Hash-Calculator
//
//  Created by Pascal Kimmel on 22-10-17.
//  Copyright © 2017 Pascal Kimmel. All rights reserved.
//

import Foundation

class StateController {
    
    fileprivate let storageController: StorageController
    
    var pluHashes: [PluHash] {
        get {
            return storageController.fetchPluHashes()
        }
        set {
            storageController.save(newValue)
        }
    }
    
    init(storageController: StorageController) {
        self.storageController = storageController
    }
    
}
