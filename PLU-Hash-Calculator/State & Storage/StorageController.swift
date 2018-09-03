//
//  StorageController.swift
//  PLU-Hash-Calculator
//
//  Created by Pascal Kimmel on 22-10-17.
//  Copyright © 2017 Pascal Kimmel. All rights reserved.
//

import Foundation

class StorageController {
    fileprivate let cachesDirectoryURL = FileManager.default
        .urls(for: .cachesDirectory, in: .userDomainMask)
        .first!

    func save(_ pluHashes: [PluHash]) {
        let pluHashesPlist = pluHashes.map{$0.serialization} as NSArray
        pluHashesPlist.write(to: fileUrl(for: .pluHashes), atomically: true)
    }
    
    func fetchPluHashes() -> [PluHash] {
        guard let data = NSArray(contentsOf: fileUrl(for: .pluHashes)) as? [Serialization] else {
            return loadSampleData()
        }
        return data.map(PluHash.init)
    }
}

fileprivate extension StorageController {
    func loadSampleData() -> [PluHash] {
        let dataFilePath = Bundle.main.path(forResource: "SampleData", ofType: "plist")!
        let data = NSArray(contentsOfFile: dataFilePath) as! [Serialization]
        return data.map(PluHash.init)
    }
    
    enum Storage: String {
        case pluHashes
    }
    
    func fileUrl(for storage: Storage) -> URL {
        return cachesDirectoryURL
            .appendingPathComponent(storage.rawValue)
            .appendingPathExtension("plist")
    }
}
