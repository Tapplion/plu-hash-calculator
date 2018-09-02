//
//  StorageController.swift
//  PLU-Hash-Calculator
//
//  Created by Pascal Kimmel on 22-10-17.
//  Copyright © 2017 Pascal Kimmel. All rights reserved.
//

import Foundation

class StorageController {
    
    fileprivate let documentsDirectoryURL = FileManager.default
        .urls(for: .documentDirectory, in: .userDomainMask)
        .first!
    
    fileprivate var pluHashesFileURL: URL {
        return documentsDirectoryURL
            .appendingPathComponent("PluHashes")
            .appendingPathExtension("plist")
    }
    
    func save(_ pluHashes: [PluHash]) {
        let pluHashesPlist = pluHashes.map { $0.plistRepresentation } as NSArray
        pluHashesPlist.write(to: pluHashesFileURL, atomically: true)
    }
    
    func fetchPluHashes() -> [PluHash] {
        guard let pluHashesPlist = NSArray(contentsOf: pluHashesFileURL) as? [[String: AnyObject]] else {
            return loadSampleData()
        }
        return pluHashesPlist.map(PluHash.init(plist:))
    }
    
}

fileprivate extension StorageController {
    
    func loadSampleData() -> [PluHash] {
        let test = Bundle.main.path(forResource: "SampleData", ofType: "plist", inDirectory: "Stage & Storage")!
        print(test)
        let data = NSArray(contentsOfFile: test) as! [[String: AnyObject]]
        return data.map(PluHash.init(plist:))
    }
    
}
