//
//  ItemCell.swift
//  PLU-Hash-Calculator
//
//  Created by Pascal Kimmel on 22-10-17.
//  Copyright © 2017 Pascal Kimmel. All rights reserved.
//

import UIKit

class ItemCell: UITableViewCell {
    @IBOutlet fileprivate weak var quantityLabel: UILabel!
    @IBOutlet fileprivate weak var nameLabel: UILabel!
    @IBOutlet fileprivate weak var priceLabel: UILabel!
    @IBOutlet fileprivate weak var vatSignLabel: UILabel!
    
    func configureCell(forItem item: Item) {
            
        quantityLabel.text = item.quantity.decimalQuantity()
        nameLabel.text = item.name
        priceLabel.text = item.price.decimalPrice()
        vatSignLabel.text = item.vatSign
    }
}
