//
//  Float.swift
//  PLU-Hash-Calculator
//
//  Created by Pascal Kimmel on 15-05-18.
//  Copyright © 2018 Pascal Kimmel. All rights reserved.
//

import Foundation

extension FloatingPoint {
    var isInt: Bool {
        return floor(self) == self
    }
}
