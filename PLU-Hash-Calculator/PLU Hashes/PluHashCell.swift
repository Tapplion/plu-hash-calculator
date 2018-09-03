//
//  PluHashCell.swift
//  PLU-Hash-Calculator
//
//  Created by Pascal Kimmel on 22-10-17.
//  Copyright © 2017 Pascal Kimmel. All rights reserved.
//

import UIKit

class PluHashCell: UITableViewCell {
    @IBOutlet fileprivate weak var pluHashLabel: UILabel!
    @IBOutlet fileprivate weak var referenceLabel: UILabel!

    var value: String? {
        didSet {
            pluHashLabel.text = value?.substringWith(numberOfcharacters: 8, fromThe: .right)
        }
    }
    
    var reference: String? {
        didSet {
            referenceLabel.text = reference
        }
    }
}
